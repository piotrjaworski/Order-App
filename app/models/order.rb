class Order < ActiveRecord::Base
  has_many :products
  belongs_to :user
  belongs_to :restaurant

  validates :restaurant_id, presence: true

  accepts_nested_attributes_for :products, allow_destroy: true

end
