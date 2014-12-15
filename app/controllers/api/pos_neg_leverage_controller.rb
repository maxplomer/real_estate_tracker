class Api::PosNegLeverageController < ApplicationController

  def update
    @pos_neg_leverage = current_user.pos_neg_leverage

    @pos_neg_leverage.purchase_price = params[:pos_neg_leverage][:purchase_price]
    @pos_neg_leverage.cap_rate = params[:pos_neg_leverage][:cap_rate]
    @pos_neg_leverage.loan_amount = params[:pos_neg_leverage][:loan_amount]
    @pos_neg_leverage.low_interest_rate = params[:pos_neg_leverage][:low_interest_rate]
    @pos_neg_leverage.high_interest_rate = params[:pos_neg_leverage][:high_interest_rate]
    @pos_neg_leverage.interest_only = (params[:pos_neg_leverage][:interest_only].downcase == "yes")
    @pos_neg_leverage.amortization = params[:pos_neg_leverage][:amortization]
    
    if @pos_neg_leverage.save
      render :show
    else
      render :json => @pos_neg_leverage.errors, :status => :unprocessable_entity
    end

  end

end
