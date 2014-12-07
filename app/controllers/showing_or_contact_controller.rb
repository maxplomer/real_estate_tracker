class ShowingOrContactController < ApplicationController

  def new
  	@properties = current_user.properties
    render :new
  end	

  def create_showing
    @showing = Showing.new(showing_params)  
    
    if @showing.save
      redirect_to dashboard_show_url
    else
      flash.now[:errors] = @showing.errors.full_messages
      render :new
    end
  end

  def create_contact
    @contact = Contact.new(contact_params)  
    
    if @contact.save
      redirect_to property_url(@contact.property)
    else
      flash.now[:errors] = @contact.errors.full_messages
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(
      :name, 
      :title, 
      :email, 
      :company, 
      :phone
    )
  end

  def showing_params
    params.require(:contact).permit(
      :name, 
      :title, 
      :email, 
      :company, 
      :phone
    )
  end

end
