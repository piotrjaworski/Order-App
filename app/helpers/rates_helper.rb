module RatesHelper

  def rate(object)
    rate = object.rates.average(:score)
  end

  def find_rate(object)
    object.rates.where(user_id: current_user.id).first.id
  end

  def show_item_in_public_activity(object)
    object.product.present? ? object.product.name : object.restaurant.name
  end

  def user_rate(object)
    rate = object.rates.where(user_id: current_user.id)
    score = rate.present? ? rate.first.score.to_i : 0
    difference = 5 - score
    if score > 0
      if difference > 0
        ("<i class='fa fa-star'></i>" * score + "<i class='fa fa-star-o'></i>" * difference).html_safe
      else
        ("<i class='fa fa-star'></i>" * score).html_safe
      end
    else
      "Not rated"
    end
  end

  def average_rate(object)
    rates = object.rates.pluck(:score).inject(:+).to_i
    difference = 5 - rates
    if object.rates.present?
      if difference > 0
        ("<i class='fa fa-star'></i>" * rates + "<i class='fa fa-star-o'></i>" * difference).html_safe
      else
        ("<i class='fa fa-star'></i>" * rates).html_safe
      end
    else
      "Not rated"
    end
  end
end
