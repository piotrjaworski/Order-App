class OrdersController < MethodsController

  def index
    typehead
  end

  def today_orders
    orders_collects_calls
    @your_order = current_user.orders.where("created_at >= ?", Time.zone.now.beginning_of_day).length >= 1

    typehead

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
    products_typehead
    render :show_form
  end

  def create
    @order = Order.create(order_params)
    if @order.save
      @order.update_attributes(user_id: current_user.id)
      @order.create_activity :create, owner: current_user
      orders_collects_calls
      flash.now[:success] = "Order has been added!"
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
    @order = Order.find(params[:id])
    @restaurants = Restaurant.all
  end

  def destroy
    @order = Order.find(params[:id])
    orders_collects_calls
    if @order.ordered != true
      @order.destroy
      @order.create_activity :destroy, owner: current_user
      flash.now[:success] = "Order has been deleted!"
    else
      flash.now[:error] = "You can't destroy ordered item!"
    end
  end

  def history
    @user_orders = current_user.orders
    @user_orders_paginate = @user_orders.order("updated_at DESC").paginate(page: params[:page], per_page: 15)

    typehead
  end

  def stats
  end

  private

  # => to edit this permit!
  def order_params
    params.require(:order).permit!
  end

  def products_typehead
    @products_typehead = Product.select(:name).distinct.map(&:name)
  end

end
