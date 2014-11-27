module CallsHelper

  def estimated_time(object)
    est_time = object.created_at + object.delivery_time.minutes
    left_time = est_time - DateTime.now.in_time_zone("London")
    left = (left_time/60).to_i
    if left >= 0
      return "Delivery estimated time: #{left} minutes."
    else
      return "Delivery should be done!"
    end
  end

end
