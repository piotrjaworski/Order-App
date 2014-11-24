class CallsController < ApplicationController

  def new
    @call = Call.new
    render :show_form
  end

  def create
    @call = Call.create(call_params)
    if @call.save
      @call.update_attributes(user_id: current_user.id)
      # today_orders
      # @today_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
      redirect_to root_path
    # else
    #   render :show_form
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

  def today_orders
    @orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
  end

end
