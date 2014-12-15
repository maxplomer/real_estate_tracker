class Api::PropertiesController < ApplicationController

  def update
    @property = Property.find(params[:id])

    @property.income = params[:property][:income]
    @property.expenses = params[:property][:expenses]
    @property.purchase_price = params[:property][:purchase_price]
    @property.interest_rate = params[:property][:interest_rate]
    @property.loan_amount = params[:property][:loan_amount]
    @property.interest_only = (params[:property][:interest_only].downcase == "yes")
    @property.amortization = params[:property][:amortization]

    @property.interest_rate = truncate(@property.interest_rate)

    if @property.save
      render :show
    else
      render :json => @property.errors, :status => :unprocessable_entity
    end
  end

  private

  def truncate(x)
    (x * 100).floor / 100.0
  end

end
