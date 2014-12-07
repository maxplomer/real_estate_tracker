class PropertiesController < ApplicationController
  def index
    @properties = Property.all
    render :index
  end

  def create
    @property = Property.new(property_params)  #can later try to refill the form if error occured

    @property.income = 0
    @property.expenses = 0
    @property.purchase_price = 0
    @property.interest_rate = 0
    @property.loan_amount = 0

    if @property.save
      redirect_to property_url(@property)
    else
      flash.now[:errors] = @property.errors.full_messages
      render :new
    end
  end

  def new
    @property = Property.new
    render :new
  end

  def show
    @property = Property.find(params[:id])

    if !signed_in? || @property.user != current_user 
      View.create(property_id: @property.id)
    end

    render :show
  end

  private

  def property_params
    params.require(:property).permit(
      :user_id, 
      :address, 
      :floor, 
      :asking_rent, 
      :rsf_available, 
      :floorplan_url, 
      :picture_url
    )
  end

end
