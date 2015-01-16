class UsersController < MethodsController
  before_action :set_user, only: [:show]
  before_action :typehead

  def index
    @users = User.all
    @users = @users.order("name ASC")
    @users = @users.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @activities = PublicActivity::Activity
                                          .order("created_at DESC")
                                          .where(owner_id: @user.id)
                                          .where("created_at >= ?", 1.month.ago)
    @orders = Order.where(user_id: @user.id).limit(15).reverse
    @rates = Rate.where(user_id: @user.id).limit(15).reverse
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
