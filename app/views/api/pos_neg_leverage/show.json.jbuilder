json.net_operating_income number_with_precision(
    @pos_neg_leverage.net_operating_income, 
    :precision => 0, 
    :delimiter => ','
  )

json.debt_service_low_interest_rate number_with_precision(
    @pos_neg_leverage.debt_service_low_interest_rate, 
    :precision => 0, 
    :delimiter => ','
  )

json.debt_service_high_interest_rate number_with_precision(
    @pos_neg_leverage.debt_service_high_interest_rate, 
    :precision => 0, 
    :delimiter => ','
  )

json.cash_flow_low_interest_rate number_with_precision(
    @pos_neg_leverage.cash_flow_low_interest_rate, 
    :precision => 0, 
    :delimiter => ','
  )

json.cash_flow_high_interest_rate number_with_precision(
    @pos_neg_leverage.cash_flow_high_interest_rate, 
    :precision => 0, 
    :delimiter => ','
  )

json.cash_on_cash_low_interest_rate @pos_neg_leverage.cash_on_cash_low_interest_rate
json.cash_on_cash_high_interest_rate @pos_neg_leverage.cash_on_cash_high_interest_rate



