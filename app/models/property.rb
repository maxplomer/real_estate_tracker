class Property < ActiveRecord::Base

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
    self.income - self.expenses
  end

  def debt_service
    truncate(self.interest_rate / 100 * self.loan_amount)
  end

  def cash_flow
    net_operating_income - debt_service
  end

  def cash_on_cash
    return "n/a" if down_payment == 0
    truncate(cash_flow / down_payment * 100)
  end

  def cap_rate
    truncate(net_operating_income / self.purchase_price)
  end

  def down_payment
    self.purchase_price - self.loan_amount
  end


  private

    def truncate(x)
    (x * 100).floor / 100.0
  end



	
end
