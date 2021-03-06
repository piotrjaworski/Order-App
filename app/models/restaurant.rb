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

end
