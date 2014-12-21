class Collect < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :user
end
