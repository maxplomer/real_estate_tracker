json.net_operating_income number_with_precision(
    @property.net_operating_income, 
    :precision => 0, 
    :delimiter => ','
  )

json.debt_service number_with_precision(
    @property.debt_service, 
    :precision => 0, 
    :delimiter => ','
  )

json.cash_flow number_with_precision(
    @property.cash_flow, 
    :precision => 0, 
    :delimiter => ','
  )

json.cash_on_cash  @property.cash_on_cash
json.cap_rate @property.cap_rate

json.down_payment number_with_precision(
    @property.down_payment, 
    :precision => 0, 
    :delimiter => ','
  )

json.loan_to_value @property.loan_to_value
json.dscr @property.dscr








