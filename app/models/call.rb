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

  def estimated_time
    est_time = created_at + delivery_time.minutes
    left_time = est_time - DateTime.now.in_time_zone("London")
    left = (left_time/60).to_i
    if left >= 0
      return "Delivery estimated time: #{left} minutes."
    else
      return "Delivery should be done!"
    end
  end

end
