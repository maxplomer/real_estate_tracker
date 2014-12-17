class Api::PosNegLeverageController < ApplicationController

  def update
    @pos_neg_leverage = current_user.pos_neg_leverage

    @pos_neg_leverage.purchase_price = remove_doubles(params[:pos_neg_leverage][:purchase_price].gsub(/[^\d.-]/, ''))
    @pos_neg_leverage.cap_rate = remove_doubles(params[:pos_neg_leverage][:cap_rate].gsub(/[^\d.-]/, ''))
    @pos_neg_leverage.loan_amount = remove_doubles(params[:pos_neg_leverage][:loan_amount].gsub(/[^\d.-]/, ''))
    @pos_neg_leverage.low_interest_rate = remove_doubles(params[:pos_neg_leverage][:low_interest_rate].gsub(/[^\d.-]/, ''))
    @pos_neg_leverage.high_interest_rate = remove_doubles(params[:pos_neg_leverage][:high_interest_rate].gsub(/[^\d.-]/, ''))
    @pos_neg_leverage.interest_only = (params[:pos_neg_leverage][:interest_only].downcase == "yes")
    @pos_neg_leverage.amortization = remove_doubles(params[:pos_neg_leverage][:amortization].gsub(/[^\d.-]/, ''))
    
    @pos_neg_leverage.cap_rate = truncate(@pos_neg_leverage.cap_rate)
    @pos_neg_leverage.low_interest_rate = truncate(@pos_neg_leverage.low_interest_rate)
    @pos_neg_leverage.high_interest_rate = truncate(@pos_neg_leverage.high_interest_rate)

    @pos_neg_leverage.purchase_price = @pos_neg_leverage.purchase_price.floor
    @pos_neg_leverage.loan_amount = @pos_neg_leverage.loan_amount.floor
    @pos_neg_leverage.amortization = @pos_neg_leverage.amortization.floor

    if @pos_neg_leverage.save
      render :show
    else
      render :json => @pos_neg_leverage.errors, :status => :unprocessable_entity
    end

  end

end
