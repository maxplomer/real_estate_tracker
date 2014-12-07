class DashboardController < ApplicationController
  def show
  	property_id = current_user.properties.first.id
    redirect_to dashboard_url(property_id)
  end
end
