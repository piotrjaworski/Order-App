class CallsController < MethodsController

  def new
    @call = Call.new
    render :show_form
  end

  def create
    @call = current_user.calls.build(call_params)
    orders_collects_calls
    if @call.save
      @orders.each { |order| order.update_attributes(ordered: true) }
      @call.create_activity :create, owner: current_user
      flash.now[:success] = "Thank you for calling!"
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
