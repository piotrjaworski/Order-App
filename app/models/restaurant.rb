class Restaurant < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :user
  has_many :orders

  validates :name, presence: true, uniqueness: true
  validates :short_info, presence: true
  validates :restaurant_type, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  TYPES = ["Chinese Restaurant", "Fast Food", "Cafe", "Pub", "Pizzeria", "Dinner"]
end
