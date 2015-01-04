class Rate < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :user
  belongs_to :restaurant
  belongs_to :product

  Scores = %w[1 2 3 4 5]
end
