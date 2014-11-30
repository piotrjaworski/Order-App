class ProfileController < MethodsController
  def index
    @user = current_user
    @latest_orders = @user.orders.limit(5).order("created_at DESC")
    @latest_restaurants = @user.restaurants.limit(5).order("created_at DESC")
  end
end
