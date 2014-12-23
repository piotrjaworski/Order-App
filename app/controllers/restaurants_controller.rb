class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
    render :show_form
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    @restaurants = Restaurant.all
    if @restaurant.save
      @restaurant.update_attributes(user_id: current_user.id)
      @restaurant.create_activity :create, owner: current_user
      render :hide_form
    else
      render :show_form
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    render :show_form
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurants = Restaurant.all
    if @restaurant.save
      @restaurant.update_attributes(restaurant_params)
      @restaurant.create_activity :update, owner: current_user
      render :hide_form
    else
      render :show_form
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @restaurant_map_params = "https://www.google.com/maps/embed/v1/place?key=AIzaSyA0rwZm3ycPPL_bwLo93jTnpTUWphpRmzs&q=" + @restaurant.latitude.to_s + "," + @restaurant.longitude.to_s + "&zoom=17"
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.create_activity :destroy, owner: current_user
    @restaurant.destroy
    @restaurants = Restaurant.all
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:short_info, :name, :user_id, :restaurant_type, :address, :logo, :latitude, :longitude)
  end

end
