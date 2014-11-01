class OrdersController < ApplicationController

  def index
    today_orders
    sum(@orders)
  end

  def new
    @order = Order.new
    render :show_form
  end

  def create
    @order = Order.create(order_params)
    if @order.save
      @order.update_attributes(user_id: current_user.id)
      today_orders
      sum(@orders)
      render :hide_form
    else
      render :show_form
    end
  end

  def edit
    @order = Order.find(params[:id])
    render :show_form
  end

  def update
    @order = Order.find(params[:id])
    if @order.save
      @order.update_attributes(order_params)
      today_orders
      sum(@orders)
      render :hide_form
    else
      render :show_form
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    today_orders
    sum(@orders)
  end

  private

  def order_params
    params.require(:order).permit(:short_info, :price, :user_id, :restaurant)
  end

  def sum(object)
    sum = []
    object.each do |order|
      sum << order.price
    end
    @sum = sum.inject(:+)
  end

  def today_orders
    @orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
  end

end
