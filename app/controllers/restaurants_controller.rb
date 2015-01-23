class RestaurantsController < MethodsController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :typehead, expect: [:new, :edit, :show]
  before_action :restaurants_pagination, only: [:index, :create, :update, :destroy]

  def index
  end

  def new
    @restaurant = Restaurant.new
    render :show_form
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.creator_id = current_user.id
    if @restaurant.save
      @restaurant.create_activity :create, owner: current_user
      render :hide_form
    else
      render :show_form
    end
  end

  def edit
    render :show_form
  end

  def update
    if @restaurant.save
      @restaurant.update_attributes(restaurant_params)
      @restaurant.create_activity :update, owner: current_user
      render :hide_form
    else
      render :show_form
    end
  end

  def show
    @restaurant_map_params = "https://www.google.com/maps/embed/v1/place?key=AIzaSyA0rwZm3ycPPL_bwLo93jTnpTUWphpRmzs&q=" + @restaurant.latitude.to_s + "," + @restaurant.longitude.to_s + "&zoom=17"
  end

  def destroy
    @restaurant.create_activity :destroy, owner: current_user
    @restaurant.destroy
  end

  private

    def restaurant_params
      params.require(:restaurant).permit(:short_info, :name, :creator_id, :restaurant_type, :address, :latitude, :longitude)
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurants_pagination
      @restaurants = Restaurant.all
      @restaurants = @restaurants.order("name ASC")
      @restaurants = @restaurants.paginate(page: params[:page], per_page: 10)
    end
end
