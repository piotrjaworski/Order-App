class RatesController < MethodsController
  before_action :set_rate, only: [:edit]
  before_action :typehead, only: [:create, :update, :rate_products, :rate_restaurants]

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
        products_to_rate
      restaurants_to_rate
      if @rate.product_id.present?
        render :hide_form_product
      elsif @rate.restaurant_id.present?
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
      @products_to_rate = []
      @products_rated = []
      current_user.orders.each do |order|
        order.products.each do |product|
          @products_to_rate << product if product.rates.where(user_id: current_user.id).empty?
          @products_rated << product if product.rates.where(user_id: current_user.id).present?
        end
      end
      @products_to_rate = @products_to_rate.uniq { |p| p.name }
      @products_rated = @products_rated.uniq { |p| p.name }
    end

    def restaurants_to_rate
      @restaurants_to_rate = current_user.restaurants
      @restaurants_rated = current_user.restaurants
      # current_user.orders.each do |order|
      #   @restaurants_to_rate << order.restaurant if order.restaurant.rates.where(user_id: current_user.id).empty?
      #   @restaurants_rated << order.restaurant if order.restaurant.rates.where(user_id: current_user.id).present?
      # end
      # @restaurants_to_rate = @restaurants_to_rate.uniq { |r| r.name }
      # @restaurants_rated = @restaurants_rated.uniq { |r| r.name }
    end
end
