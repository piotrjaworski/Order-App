class CollectsController < MethodsController

  def create
    @collect = current_user.collects.create
    @collect.create_activity :create, owner: current_user
    orders_collects_calls
    redirect_to(root_path) and return if @collect.save
  end

  private

    def collect_params
      params.require(:collect).permit(:user_id)
    end

end
