class OrdersController < MethodsController

  def index
    # => for Prawn pdf
    @today_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    @today_call = Call.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @today_collect = Collect.where("created_at >= ?", Time.zone.now.beginning_of_day)
    today_orders

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
      @today_collect = Collect.where("created_at >= ?", Time.zone.now.beginning_of_day)
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
      @today_collect = Collect.where("created_at >= ?", Time.zone.now.beginning_of_day)
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
    @today_collect = Collect.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

  def history
    @user_orders = current_user.orders
    @user_orders_paginate = @user_orders.order("updated_at DESC").paginate(page: params[:page], per_page: 5)
  end

  private

  # => to edit this permit!
  def order_params
    params.require(:order).permit!
  end
end
