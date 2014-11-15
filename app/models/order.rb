class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validates :short_info, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :restaurant_id, presence: true
end
