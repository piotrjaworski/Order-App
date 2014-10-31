class Order < ActiveRecord::Base
  belongs_to :user

  validates :short_info, presence: true
  validates :price, presence: true
  validates :restaurant, presence: true
end
