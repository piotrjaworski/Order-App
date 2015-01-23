class Product < ActiveRecord::Base
  include PublicActivity::Common
  before_save :assign_restaurant

  has_and_belongs_to_many :users
  has_and_belongs_to_many :orders
  belongs_to :restaurant
  has_many :rates

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def self.search(query)
    where("name like ?", "%#{query}%")
  end

  def assign_restaurant
    self.restaurant_id = self.order.restaurant.id
  end
end

