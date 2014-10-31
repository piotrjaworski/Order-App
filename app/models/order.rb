class Order < ActiveRecord::Base
  belongs_to :user

  validates :short_info, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :restaurant, presence: true

  RESTAURANT = %w{Chinol Aniol Da-Grasso Inna}
end
