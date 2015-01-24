class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def search
    @search = params[:query]
    if @search.present?
      @products = Product.search(@search)
      @restaurants = Restaurant.search(@search)
      @results = @products + @restaurants
    end
    typehead
  end

  def after_sign_in_path_for(resource_or_scope)
   root_path
  end

  def after_sign_up_path_for(resource_or_scope)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
  end

  def typehead
    products = Product.select(:name).distinct.map(&:name)
    restaurants = Restaurant.select(:name).distinct.map(&:name)
    @typehead = products + restaurants
    @typehead.uniq!
    @typehead
  end
end
