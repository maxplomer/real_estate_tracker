class ShowingOrContactController < ApplicationController

  def new
    if current_user.properties.length > 0
  	  @properties = current_user.properties.sort! { |a,b| b.id <=> a.id }
      render :new
    else
      redirect_to new_property_url
    end
  end	

  def create_contact
    contact_or_showing = params["contact"]["contact_or_showing"]

    if contact_or_showing == "contact"
      @contact = Contact.new(contact_params)
    else
      @contact = Showing.new(contact_params) 
    end  
    
    if @contact.save
      if contact_or_showing == "contact"
        redirect_to property_url(@contact.property)
      else
        redirect_to dashboard_show_url
      end
    else
      flash[:errors] = @contact.errors.full_messages
      redirect_to showing_or_contact_new_url
    end
  end

  private

  def contact_params
    params.require(:contact).permit(
      :property_id,
      :name, 
      :title, 
      :email, 
      :company, 
      :phone
    )
  end

end
