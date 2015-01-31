class Product < ActiveRecord::Base
  include PublicActivity::Common

  has_and_belongs_to_many :users
  has_and_belongs_to_many :orders
  belongs_to :restaurant
  has_many :rates

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def self.search(query)
    where("name like ?", "%#{query}%")
  end

  def average_rate
    rates = self.rates.pluck(:score).inject(:+).to_i
    difference = 5 - rates
    if self.rates.present?
      if difference > 0
        ("<i class='fa fa-star'></i>" * rates + "<i class='fa fa-star-o'></i>" * difference).html_safe
      else
        ("<i class='fa fa-star'></i>" * rates).html_safe
      end
    else
      "Not rated"
    end
  end

  def user_rate
    rate = self.rates.where(user_id: User.current_user.id)
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

end

