class Call < ActiveRecord::Base
  include PublicActivity::Model
  tracked

  belongs_to :user

  # @orders = Order.where("updated_at >= ?", Time.zone.now.beginning_of_day)
  # today_date = DateTime.now

  def ordered?
    Call.where("created_at >= ?", Time.zone.now.beginning_of_day).exists?
  end

  def order(user)
    Order.create(user_id: user.id)
  end

  def unorder
    Order.last.destroy
  end

end
