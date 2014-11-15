class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
    render :show_form
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    if @restaurant.save
      @restaurant.update_attributes(user_id: current_user.id)
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
    if @restaurant.save
      @restaurant.update_attributes(restaurant_params)
      render :hide_form
    else
      render :show_form
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:short_info, :name, :user_id, :restaurant_type)
  end

end
