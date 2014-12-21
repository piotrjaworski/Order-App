class ProfileController < MethodsController
  def index
    @user = current_user
    @activities = PublicActivity::Activity
                                          .order("created_at DESC")
                                          .where(owner_id: @user.id)
                                          .where("created_at >= ?", 1.month.ago)
    @orders = Order.where(user_id: @user.id)
    @rates = nil
  end
end
