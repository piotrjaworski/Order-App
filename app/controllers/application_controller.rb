class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
   today_orders_path
  end

  def after_sign_up_path_for(resource_or_scope)
    today_orders_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :photo, :email, :password, :password_confirmation) }
  end
end
