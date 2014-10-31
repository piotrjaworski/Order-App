class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @oder.save
      redirect_to root_path
      flash[:success] = 'Twoje zamowienie zostalo zlozone'
    else
      redirect_to root_path
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
      redirect_to root_path
      flash[:success] = 'Twoje zamowienie zostalo zaktualizowane'
    else
      redirect_to root_path
      flash[:error] = 'Wystapil problem z aktualizacja Twojego zamownia'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to root_path
    flash[:success] = 'Twoje zamowienie zostalo usuniete'
  end

  private

  def order_params
    params.require(:order).permit(:short_info, :price, :user_id, :restaurant)
  end

end
