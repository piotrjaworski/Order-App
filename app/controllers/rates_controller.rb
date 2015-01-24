class RatesController < MethodsController
  before_action :set_rate, only: [:edit, :update]
  before_action :typehead, only: [:create, :update, :rate_products, :rate_restaurants]
  # helper_method :find_rate

  def new_product_rate
    @rate = Rate.new
    products_to_rate
    render :show_form
  end

  def new_restaurant_rate
    @rate = Rate.new
    restaurants_to_rate
    render :show_form
  end

  def create
    @rate = current_user.rates.build(rate_params)
    if @rate.save
      @rate.create_activity :create, owner: current_user
      if @rate.product_id.present?
        products_to_rate
        render :hide_form_product
      else
        restaurants_to_rate
        render :hide_form_restaurant
      end
    else
      render :show_form
    end
  end

  def edit
    render :show_form
  end

  def update
    if @rate.save
      @rate.create_activity :update, owner: current_user
      if @rate.product_id.present?
        @rate.update_attributes(rate_params)
        products_to_rate
        render :hide_form_product
      else
        @rate.update_attributes(rate_params)
        restaurants_to_rate
        render :hide_form_restaurant
      end
    end
  end

  def rate_products
    products_to_rate
  end

  def rate_restaurants
    restaurants_to_rate
  end

  private

    def rate_params
      params.require(:rate).permit(:score, :user_id, :restaurant_id, :product_id, :commnent)
    end

    def set_rate
      @rate = Rate.find(params[:id])
    end

    def products_to_rate
      @products_to_rate, @products_rated = [], []
      current_user.products.each do |product|
        product.rates.where(user_id: current_user.id).present? ? @products_rated << product : @products_to_rate << product
      end
    end

    def restaurants_to_rate
      @restaurants_to_rate, @restaurants_rated = [], []
      current_user.restaurants.each do |restaurant|
        restaurant.rates.where(user_id: current_user.id).present? ? @restaurants_rated << restaurant : @restaurants_to_rate << restaurant
      end
    end
end
