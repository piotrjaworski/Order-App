class Product < ActiveRecord::Base
  include PublicActivity::Common

  before_save :assign_restaurant

  belongs_to :order
  belongs_to :restaurant
  has_many :dates

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def self.search(query)
    where("name like ?", "%#{query}%")
  end

  def assign_restaurant
    self.restaurant_id = self.order.restaurant.id
  end
end

