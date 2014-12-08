class DashboardController < ApplicationController
  def show
  	if current_user.properties.length > 0
      property_id = current_user.properties.sort! { |a,b| b.id <=> a.id }.first.id
      redirect_to dashboard_url(property_id)
    else
      redirect_to new_property_url
    end
  end
end
