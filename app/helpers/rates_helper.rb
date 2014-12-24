module RatesHelper

  def rate(object)
    rate = object.rates.average(:score)
  end

  def user_rate(object)
    rate = object.rates.where(user_id: current_user.id).first.score
  end
end
