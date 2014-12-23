class UsersController < MethodsController

  def index
    @users = User.all
    @users = @users.order("name ASC")
    @users = @users.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @user = User.find(params[:id])
    @activities = PublicActivity::Activity
                                          .order("created_at DESC")
                                          .where(owner_id: @user.id)
                                          .where("created_at >= ?", 1.month.ago)
    @orders = Order.where(user_id: @user.id).limit(15)
    @rates = nil
    typehead
  end
end
