class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  validates :name, presence: true
  validates :short_info, presence: true
  validates :restaurant_type, presence: true
  validates :address, presence: true

  TYPES = ["Chinese Restaurant", "Fast Food", "Cafe", "Pub", "Pizzeria", "Dinner"]
end
