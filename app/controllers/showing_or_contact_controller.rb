class ShowingOrContactController < ApplicationController

  def new
    if current_user.properties.length > 0
  	  @properties = current_user.properties.sort! { |a,b| b.id <=> a.id }
      render :new
    else
      redirect_to new_property_url
    end
  end	

  def create_showing
    @showing = Showing.new(showing_params)  
    
    if @showing.save
      redirect_to dashboard_show_url
    else
      flash[:errors] = @showing.errors.full_messages
      redirect_to showing_or_contact_new_url
    end
  end

  def create_contact
    @contact = Contact.new(contact_params)  
    
    if @contact.save
      redirect_to property_url(@contact.property)
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

  def showing_params
    params.require(:showing).permit(
      :property_id,
      :name, 
      :title, 
      :email, 
      :company, 
      :phone
    )
  end

end
