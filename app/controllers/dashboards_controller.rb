class DashboardsController < ApplicationController

  def show
  	@properties = current_user.properties.sort! { |a,b| b.id <=> a.id }

    @property = Property.find(params[:id])
    render :show
  end

end
