class UsersController < ApplicationController
  before_action :require_signed_out!, :only => [:create, :new]

  def new
    @user = User.new
    render :new, :layout => false
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to dashboard_show_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new, :layout => false
    end
  end

  def show
    if params.include?(:id)
      @user = User.find(params[:id])
    else
      redirect_to user_url(current_user)
    end
  end

  def edit
    @user = current_user
    unless params.include?(:id) && current_user.id == params[:id].to_i     
      redirect_to root_url
    end
    render :edit, :layout => false
  end
  
  def update
    @user = current_user
    if params.include?(:id) && current_user.id == params[:id].to_i && @user.update_attributes(user_update_params)
      redirect_to dashboard_show_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
  def user_update_params
      params.require(:user).permit(:name, :email)
  end

end
