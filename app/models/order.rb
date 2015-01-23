class Order < ActiveRecord::Base
  include PublicActivity::Common

  has_and_belongs_to_many :products
  belongs_to :user
  belongs_to :restaurant

  scope :ordered, -> { where(ordered: true) }

  validates :restaurant_id, presence: { message: "name is required." }
  validates :products, presence: { message: "are required. Please add one or more." }

  accepts_nested_attributes_for :products, allow_destroy: true

end
