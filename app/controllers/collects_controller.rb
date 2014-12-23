class CollectsController < MethodsController

  def create
    @collect = Collect.new
    @collect = Collect.create
    @collect.create_activity :create, owner: current_user
    orders_collects_calls
    if @collect.save
      @collect.update_attributes(user_id: current_user.id)
      redirect_to(today_orders_path) and return
    end
  end

  private

  def collect_params
    params.require(:collect).permit(:user_id)
  end

end
