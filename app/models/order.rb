class Order < ActiveRecord::Base
  include PublicActivity::Common

  has_many :products
  belongs_to :user
  belongs_to :restaurant

  scope :ordered, -> { where(ordered: true) }

  validates :restaurant_id, presence: true

  accepts_nested_attributes_for :products, allow_destroy: true

end
