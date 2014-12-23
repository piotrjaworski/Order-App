class Rate < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :user
  belongs_to :restaurant
  belongs_to :product
end
