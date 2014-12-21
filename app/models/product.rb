class Product < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :order

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end

