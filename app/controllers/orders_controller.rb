class OrdersController < ApplicationController

  def index
    @orders = Order.all

    # => count sum
    sum = []
    @orders.each do |order|
      sum << order.price
    end
    @sum = sum.inject(:+)
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      @order.update_attributes(user_id: current_user.id)
      redirect_to orders_path
      flash[:success] = 'Twoje zamowienie zostalo zapisane'
    else
      redirect_to orders_path
      flash[:error] = 'Wystapil problem z Twoim zamowieniem'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes(order_params)

    if @order.save
      @order.update_attributes(user_id: current_user.id)
      redirect_to orders_path
      flash[:success] = 'Twoje zamowienie zostalo zaktualizowane'
    else
      redirect_to orders_path
      flash[:error] = 'Wystapil problem z aktualizacja Twojego zamownia'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_path
    flash[:success] = 'Twoje zamowienie zostalo usuniete'
  end

  private

  def order_params
    params.require(:order).permit(:short_info, :price, :user_id, :restaurant)
  end

end
