class DashboardsController < ApplicationController

  def show
  	@properties = current_user.properties
    @property = Property.find(params[:id])
    render :show
  end

end
