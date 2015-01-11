class OrdersController < MethodsController

  def index
    orders_collects_calls
    if user_signed_in?
      @your_order = current_user.orders.where("created_at >= ?", Time.zone.now.beginning_of_day).length >= 1
    end

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
    @order = current_user.orders.build(order_params)
    @restaurants = Restaurant.all
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
    typehead
  end

  def stats
    typehead
  end

  private

    def order_params
      params.require(:order).permit(:short_info, :restaurant_id, {:products_attributes => [:name, :price]})
    end

    def products_typehead
      @products_typehead = Product.select(:name).distinct.map(&:name)
    end
end
