class PosNegLeverageController < ApplicationController

  def show
    @pos_neg_leverage = current_user.pos_neg_leverage
    render :show
  end

end
