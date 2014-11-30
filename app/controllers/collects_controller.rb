class CollectsController < MethodsController

  def create
    @collect = Collect.new
    @collect = Collect.create
    today_orders
    @today_call = Call.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @today_orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
    @today_collect = Collect.where("created_at >= ?", Time.zone.now.beginning_of_day)
    if @collect.save
      @collect.update_attributes(user_id: current_user.id)
      redirect_to(root_path) and return
    end
  end

  private

  def collect_params
    params.require(:collect).permit(:user_id)
  end

end