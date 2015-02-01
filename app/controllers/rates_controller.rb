class RatesController < MethodsController
  before_action :set_rate, only: [:edit, :update]
  before_action :typehead, only: [:create, :update, :rate_products, :rate_restaurants]

  def new_product_rate
    @rate = Rate.new
    @products_to_rate = collect_items(current_user.products)
    render :show_form
  end

  def new_restaurant_rate
    @rate = Rate.new
    @restaurants_to_rate = collect_items(current_user.restaurants)
    render :show_form
  end

  def create
    @rate = current_user.rates.build(rate_params)
    if @rate.save
      @rate.create_activity :create, owner: current_user
      if @rate.product_id.present?
        collect_items(current_user.products)
        render :hide_form_product
      else
        collect_items(current_user.restaurants)
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
        collect_items(current_user.products)
        render :hide_form_product
      else
        @rate.update_attributes(rate_params)
        collect_items(current_user.restaurants)
        render :hide_form_restaurant
      end
    end
  end

  def rate_products
    collect_items(current_user.products)
  end

  def rate_restaurants
    collect_items(current_user.restaurants)
  end

  private

    def rate_params
      params.require(:rate).permit(:score, :user_id, :restaurant_id, :product_id, :commment)
    end

    def set_rate
      @rate = Rate.find(params[:id])
    end

    def collect_items(objects)
      @to_rate, @rated = [], []
      objects.each do |object|
        object.rates.where(user_id: current_user.id).present? ? @rated << object : @to_rate << object
      end
    end
end
