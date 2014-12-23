class Product < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :order
  has_many :dates

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def self.search(query)
    where("name like ?", "%#{query}%")
  end
end

