class Property < ActiveRecord::Base
  has_attached_file :picture
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  has_attached_file :floorplan
  validates_attachment_content_type :floorplan, :content_type => /\Aimage\/.*\Z/


  validates :user_id, :presence => true
  validates :address, :presence => true
  validates :floor, :presence => true
  validates :asking_rent, :inclusion => { 
    :in => 1..3000, 
    :message => "must be between 1 and 9,999" 
  }
  validates :rsf_available, :inclusion => { 
    :in => 1..99999999, 
    :message => "must be between 1 and 99,999,999" 
  }

  #validations for analysis
  validates :purchase_price, :inclusion => { 
    :in => 0..99999999, 
    :message => "must be between 0 and 99,999,999" 
  }
  validates :loan_amount, :inclusion => { 
    :in => 0..99999999, 
    :message => "must be between 0 and 99,999,999" 
  }
  validates :interest_rate, :inclusion => { 
    :in => 0..100, 
    :message => "must be between 0 and 100" 
  }
  validates :amortization, :inclusion => { 
    :in => 0..100, 
    :message => "must be between 0 and 100" 
  }
  validates :income, :inclusion => { 
    :in => 0..99999999, 
    :message => "must be between 0 and 99,999,999" 
  }
  validates :expenses, :inclusion => { 
    :in => 0..99999999, 
    :message => "must be between 0 and 99,999,999" 
  }





  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id
  )

  has_many(
    :contacts,
    class_name: "Contact",
    foreign_key: :property_id,
    dependent: :destroy
  )

  has_many(
    :showings,
    class_name: "Showing",
    foreign_key: :property_id,
    dependent: :destroy
  )

  has_many(
    :views,
    class_name: "View",
    foreign_key: :property_id,
    dependent: :destroy
  )

  def net_operating_income
    truncate(self.income - self.expenses)
  end

  def debt_service
    return 0 if self.loan_amount == 0
    if self.interest_only
      truncate(self.interest_rate / 100 * self.loan_amount)
    else
      return "n/a" if self.interest_rate == 0 || self.amortization == 0
      truncate(pmt(self.interest_rate/100, self.amortization, -self.loan_amount))
    end 
  end

  def cash_flow
    return "n/a" if debt_service.class == String
    truncate(net_operating_income - debt_service)
  end

  def cash_on_cash
    return "n/a" if down_payment == 0 || cash_flow.class == String
    remove_trailing_zeros(truncate(cash_flow / down_payment * 100))
  end

  def cap_rate
    return "n/a" if self.purchase_price == 0
    remove_trailing_zeros(truncate(net_operating_income / self.purchase_price * 100))
  end

  def down_payment
    truncate(self.purchase_price - self.loan_amount)
  end

  def loan_to_value
    return "n/a" if self.purchase_price == 0
    remove_trailing_zeros(truncate(self.loan_amount / self.purchase_price * 100))
  end

  def dscr
    return "n/a" if debt_service == 0 || debt_service.class == String
    remove_trailing_zeros(truncate(net_operating_income / debt_service))
  end

  private

  def remove_trailing_zeros(x)
    if x == x.to_i
      x.to_i
    else
      x
    end
  end

  def truncate(x)
    (x * 100).floor / 100.0
  end

  def pmt(rate, nper, pv, fv=0, type=0)
    ((-pv * pvif(rate, nper) - fv ) / ((1.0 + rate * type) * fvifa(rate, nper)))
  end
 
  def ipmt(rate, per, nper, pv, fv=0, type=0)
    p = pmt(rate, nper, pv, fv, 0);
    ip = -(pv * pow1p(rate, per - 1) * rate + p * pow1pm1(rate, per - 1))
    (type == 0) ? ip : ip / (1 + rate)
  end
  
  def ppmt(rate, per, nper, pv, fv=0, type=0)
    p = pmt(rate, nper, pv, fv, type)
    ip = ipmt(rate, per, nper, pv, fv, type)
    p - ip
  end
    
  #helpers

  def pow1pm1(x, y)
    (x <= -1) ? ((1 + x) ** y) - 1 : Math.exp(y * Math.log(1.0 + x)) - 1
  end
  
  def pow1p(x, y)
    (x.abs > 0.5) ? ((1 + x) ** y) : Math.exp(y * Math.log(1.0 + x))
  end
  
  def pvif(rate, nper)
    pow1p(rate, nper)
  end
  
  def fvifa(rate, nper)
    (rate == 0) ? nper : pow1pm1(rate, nper) / rate
  end

end
