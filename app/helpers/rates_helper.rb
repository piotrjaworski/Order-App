module RatesHelper

  def rate(object)
    rate = object.rates.average(:score)
  end

  def user_rate(object)
    rate = object.rates.where(user_id: current_user.id).first.score
  end

  def find_rate(object)
    object.rates.where(user_id: current_user.id).first.id
  end

  def show_item_in_public_activity(object)
    object.product.present? ? object.product.name : object.restaurant.name
  end
end
