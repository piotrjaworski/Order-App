class RestaurantsController < MethodsController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]

  def index
    restaurants_pagination
    typehead
  end

  def new
    @restaurant = Restaurant.new
    render :show_form
  end

  def create
    @restaurant = current_user.restaurants.build(restaurant_params)
    restaurants_pagination
    if @restaurant.save
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
    restaurants_pagination
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
    restaurants_pagination
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:short_info, :name, :user_id, :restaurant_type, :address, :logo, :latitude, :longitude)
  end

  def restaurants_pagination
    @restaurants = Restaurant.all
    @restaurants = @restaurants.order("name ASC")
    @restaurants = @restaurants.paginate(page: params[:page], per_page: 10)
  end

end
