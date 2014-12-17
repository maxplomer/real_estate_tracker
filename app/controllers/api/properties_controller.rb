class Api::PropertiesController < ApplicationController

  def update
    @property = Property.find(params[:id])

    @property.income = remove_doubles(params[:property][:income].gsub(/[^\d.-]/, ''))
    @property.expenses = remove_doubles(params[:property][:expenses].gsub(/[^\d.-]/, ''))
    @property.purchase_price = remove_doubles(params[:property][:purchase_price].gsub(/[^\d.-]/, ''))
    @property.interest_rate = remove_doubles(params[:property][:interest_rate].gsub(/[^\d.-]/, ''))
    @property.loan_amount = remove_doubles(params[:property][:loan_amount].gsub(/[^\d.-]/, ''))
    @property.interest_only = (params[:property][:interest_only].downcase == "yes")
    @property.amortization = remove_doubles(params[:property][:amortization].gsub(/[^\d.-]/, ''))

    @property.interest_rate = truncate(@property.interest_rate)

    @property.income = @property.income.floor
    @property.expenses = @property.expenses.floor
    @property.purchase_price = @property.purchase_price.floor
    @property.loan_amount = @property.loan_amount.floor
    @property.amortization = @property.amortization.floor

    if @property.save
      render :show
    else
      render :json => @property.errors, :status => :unprocessable_entity
    end
  end

end
