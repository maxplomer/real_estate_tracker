class PropertiesController < ApplicationController

  # start - old update before live JavaScript form
  # def update
  #   @property = Property.find(params[:id])

  #   @property.income = params[:property][:income]
  #   @property.expenses = params[:property][:expenses]
  #   @property.purchase_price = params[:property][:purchase_price]
  #   @property.interest_rate = params[:property][:interest_rate]
  #   @property.loan_amount = params[:property][:loan_amount]
  #   @property.interest_only = (params[:property][:interest_only].downcase == "yes")
  #   @property.amortization = params[:property][:amortization]

  #   if @property.save
  #     redirect_to dashboard_url(@property)
  #   else
  #     flash[:errors] = @property.errors.full_messages
  #     redirect_to dashboard_url(@property)
  #   end
  # end
  # end - old update before live JavaScript form

  def index
    @properties = Property.all.sort! { |a,b| b.id <=> a.id }
    render :index
  end

  def create
    @property = Property.new(property_params)  #can later try to refill the form if error occured

    @property.income = 50000
    @property.expenses = 5000
    @property.purchase_price = 400000
    @property.interest_rate = 4.5
    @property.loan_amount = 200000
    @property.interest_only = false
    @property.amortization = 15

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
      :picture,
      :floorplan
    )
  end

end
