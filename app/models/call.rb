class Call < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :user

  def ordered?
    Call.where("created_at >= ?", Time.zone.now.beginning_of_day).exists?
  end

  def order(user)
    Order.create(user_id: user.id)
  end

  def unorder
    current_user.order.last.destroy
  end

end
