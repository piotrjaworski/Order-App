class OrdersController < ApplicationController
  helper_method :show_products, :count_price, :count_total_price
  before_action :authenticate_user!, except: :index

  def index
    # => for Prawn pdf
    @today_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    @today_call = Call.where("created_at >= ?", Time.zone.now.beginning_of_day)
    today_orders
    #binding.pry
    respond_to do |format|
      format.html
      format.pdf do
        pdf = OrderPdf.new(@today_orders)
        send_data pdf.render, filename: "Today_orders_raport.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def new
    @order = Order.new
    @restaurants = Restaurant.all
    render :show_form
  end

  def create
    @order = Order.create(order_params)
    if @order.save
      @order.update_attributes(user_id: current_user.id)
      today_orders
      @today_call = Call.where("created_at >= ?", Time.zone.now.beginning_of_day)
      @today_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
      render :hide_form
    else
      render :show_form
    end
  end

  def edit
    @order = Order.find(params[:id])
    @restaurants = Restaurant.all
    render :show_form
  end

  def update
    @order = Order.find(params[:id])
    if @order.save
      @order.update_attributes(order_params)
      today_orders
      @today_call = Call.where("created_at >= ?", Time.zone.now.beginning_of_day)
      @today_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
      count_total_price(today_orders)
      render :hide_form
    else
      render :show_form
    end
  end

  def show
    @order = Order.find(params[:id])
    @restaurants = Restaurant.all
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    today_orders
    @today_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
  end

  def history
    @user_orders = current_user.orders
  end

  private

  # => to edit this permit!
  def order_params
    params.require(:order).permit!
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

  def show_products(object)
    object.products.map(&:name).join(", ")
  end

  def today_orders
    @orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
  end

end
