class CallsController < MethodsController

  def new
    @call = Call.new
    render :show_form
  end

  def create
    @call = Call.create(call_params)
    @today_call = Call.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @today_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    @today_collect = Collect.where("created_at >= ?", Time.zone.now.beginning_of_day)
    if @call.save
      @today_orders.each { |order| order.update_attributes(ordered: true) }
      @call.update_attributes(user_id: current_user.id)
      render :hide_form
    else
      render :show_form
    end
  end

  private

  def call_params
    params.require(:call).permit(:user_id, :delivery_time)
  end

end
