class Restaurant < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessor :creator

  has_and_belongs_to_many :users
  has_many :products
  has_many :rates
  has_many :orders

  validates :name, presence: true, uniqueness: true
  validates :short_info, presence: true
  validates :restaurant_type, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  TYPES = ["Chinese Restaurant", "Fast Food", "Cafe", "Pub", "Pizzeria", "Dinner"]

  def self.search(query)
    where("restaurant_type LIKE ? OR address LIKE ? OR name LIKE ? or short_info LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
  end

  def creator
    User.find(self.creator_id).try(:name)
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
