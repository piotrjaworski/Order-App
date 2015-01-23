class OrdersController < MethodsController
  before_action :set_order, only: [:show, :edit, :destroy, :update]
  before_action :typehead, expect: [:index, :create, :update, :destroy, :history, :stats]

  def index
    orders_collects_calls
    if user_signed_in?
      @your_order = current_user.orders.where("created_at >= ?", Time.zone.now.beginning_of_day).length >= 1
    end

    respond_to do |format|
      format.html
      format.pdf do
        if @today_orders.empty?
          pdf = EmptyErrorPdf.new
          send_data pdf.render, filename: "No_orders_raport.pdf", type: "application/pdf", disposition: "inline"
        else
          pdf = OrderPdf.new(@today_orders)
          send_data pdf.render, filename: "Today_orders_raport.pdf", type: "application/pdf", disposition: "inline"
        end
      end
    end
  end

  def new
    @order = Order.new
    @restaurants = Restaurant.all
    render :show_form
  end

  def create
    @order = current_user.orders.build(order_params)
    @restaurants = Restaurant.all
    @order.products.each { |p| p.restaurant_id = @order.restaurant_id }
    if @order.save
      @order.create_activity :create, owner: current_user
      orders_collects_calls
      flash.now[:success] = "Order has been added!"
      render :hide_form
    else
      render :show_form
    end
  end

  def edit
    render :show_form
  end

  def update
    orders_collects_calls
    if @order.save and @order.ordered != true
      @order.update_attributes(order_params)
      @order.create_activity :update, owner: current_user
      flash.now[:success] = "Order has been updated!"
      render :hide_form
    else
      flash.now[:error] = "Ordered order can't be updated!"
      render :hide_form
    end
  end

  def show
  end

  def destroy
    orders_collects_calls
    if @order.ordered != true
      @order.create_activity :destroy, owner: current_user
      @order.destroy
      flash.now[:success] = "Order has been deleted!"
    else
      flash.now[:error] = "You can't destroy ordered item!"
    end
  end

  def history
    @user_orders = current_user.orders
    @user_orders_paginate = @user_orders.order("updated_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def stats
  end

  private

    def order_params
      params.require(:order).permit(:short_info, :restaurant_id, {:products_attributes => [:name, :price]})
    end

    def set_order
      @order = Order.find(params[:id])
      @restaurants = Restaurant.all
    end
end
