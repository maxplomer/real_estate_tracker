class PositiveVsNegativeLeverage < ActiveRecord::Base

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id
  )

  def net_operating_income
    truncate(self.purchase_price * self.cap_rate / 100)
  end
  
  def debt_service_low_interest_rate
    debt_service(self.low_interest_rate)
  end

  def debt_service_high_interest_rate
    debt_service(self.high_interest_rate)
  end

  def debt_service(interest_rate)
    return 0 if self.loan_amount == 0
    if self.interest_only
      truncate(interest_rate / 100 * self.loan_amount)
    else
      return "n/a" if interest_rate == 0 || self.amortization == 0
      truncate(pmt(interest_rate/100, self.amortization, -self.loan_amount))
    end 
  end

  def cash_flow_low_interest_rate
    truncate(net_operating_income - debt_service_low_interest_rate)
  end

  def cash_flow_high_interest_rate
    truncate(net_operating_income - debt_service_high_interest_rate)
  end

  def cash_on_cash_low_interest_rate
    truncate(cash_flow_low_interest_rate / (self.purchase_price - self.loan_amount) * 100)
  end

  def cash_on_cash_high_interest_rate
    truncate(cash_flow_high_interest_rate / (self.purchase_price - self.loan_amount) * 100)
  end

  private

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
