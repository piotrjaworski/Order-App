class CollectsController < MethodsController

  def create
    @collect = Collect.new
    today_orders
    @today_call = Call.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @today_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    @collect.update_attributes(user_id: current_user.id)
    redirect_to root_path
    render[:success] = "Thank you!"
  end

  private

  def collect_params
    params.require(:collect).permit(:user_id)
  end

end
