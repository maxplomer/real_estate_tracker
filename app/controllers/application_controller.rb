class ApplicationController < ActionController::Base
  require 'action_view'
  include ActionView::Helpers::NumberHelper


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Expose these methods to the views
  helper_method(
    :current_user, 
    :signed_in?, 
    :remove_trailing_zeros
  )

  def truncate(x)
    (x * 100).round / 100.0
  end


  def remove_doubles(x) 
    remove_double_negative(remove_double_period(x))
  end

  def remove_double_period(x) 
    x.sub(/\./, "x")
      .gsub(/\./, "")
      .sub(/x/, ".")
  end

  def remove_double_negative(x) 
    x.sub(/\-/, "x")
      .gsub(/\-/, "")
      .sub(/x/, "-")
  end
  
  private

  def remove_trailing_zeros(x)
    if x == x.to_i
      x.to_i
    else
      x
    end
  end

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def signed_in?
    !!current_user
  end

  def sign_in(user)
    @current_user = user
    session[:token] = user.reset_session_token!
  end

  def sign_out
    current_user.try(:reset_session_token!)
    session[:token] = nil
  end

  def require_signed_in!
    redirect_to new_session_url unless signed_in?
  end

  def require_signed_out!
    sign_out if signed_in?
  end

end