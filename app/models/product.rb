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
    if self.rates.present?
      ("<i class='fa fa-star'></i>" * rates).html_safe
    else
      "Not rated"
    end
  end

  def user_rate
    rate = self.rates.where(user_id: User.current_user.id)
    score = rate.present? ? rate.first.score.to_i : 0
    if score > 0
      ("<i class='fa fa-star'></i>" * score).html_safe
    else
      "Not rated"
    end
  end

end

