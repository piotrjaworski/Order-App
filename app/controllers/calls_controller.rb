class CallsController < ApplicationController
  helper_method :show_products, :count_price, :count_total_price

  def new
    @call = Call.new
    render :show_form
  end

  def create
    @call = Call.create(call_params)
    today_orders
    @today_call = Call.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @today_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    if @call.save
      @call.update_attributes(user_id: current_user.id)
      render :hide_form
    else
      render :show_form
    end
  end

  def destroy
    @call = Call.last
    @call.destroy
    redirect_to root_path
  end

  private

  def call_params
    params.require(:call).permit(:user_id, :delivery_time)
  end

  def show_products(object)
    object.products.map(&:name).join(", ")
  end

  def today_orders
    @orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
  end

  def count_price(object)
    sum = []
    object.products.each do |product|
      sum << product.price
    end
    @sum = sum.inject(:+)
  end

  def count_total_price(objects)
    today_sum = []
    objects.each do |order|
      order.products.each do |product|
        today_sum << product.price
      end
    end
    @today_sum = today_sum.inject(:+)
  end

end
