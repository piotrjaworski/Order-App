class OrdersController < MethodsController
  before_action :set_order, only: [:show, :edit, :destroy, :update]
  before_action :typehead, expect: [:index, :create, :update, :destroy, :history, :stats]
  before_action :products_typehead, only: [:new, :edit]

  def index
    orders_collects_calls
    @your_order = current_user.orders.where("created_at >= ?", Time.zone.now.beginning_of_day).length >= 1 if user_signed_in?

    respond_to do |format|
      format.html
      format.js
      format.pdf do
        if @orders.present?
          pdf = OrderPdf.new(@orders)
          send_data pdf.render, filename: "Today_orders_raport.pdf", type: "application/pdf", disposition: "inline"
        else
          redirect_to root_path
          flash[:error] = "You cannot generate raport without orders!"
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

    @order.products.each_with_index do |product, i|
      if @found = Product.where(name: product.name, restaurant_id: product.restaurant_id).first
        @order.products[i].destroy
        @order.products << @found
      end
      if @found
        current_user.products << @found if current_user.products.where(id: @found.id).empty?
      else
        current_user.products << product if current_user.products.where(id: product.id).empty?
      end
    end

    if @order.save
      @order.create_activity :create, owner: current_user
      current_user.restaurants << @order.restaurant if current_user.restaurants.where(id: @order.restaurant.id).empty?
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
      params.require(:order).permit(:short_info, :restaurant_id, { products_attributes: [:name, :price] })
    end

    def set_order
      @order = Order.find(params[:id])
      @restaurants = Restaurant.all
    end

    def products_typehead
      @products_typehead = Product.select(:name).distinct.map(&:name)
    end
end
