class Rate < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :user
  belongs_to :restaurant
  belongs_to :product

  validates :score, presence: true

  Scores = %w[1 2 3 4 5]

  def show_score
    score = self.score.to_i
    if score > 0
      ("<i class='fa fa-star'></i>" * score).html_safe
    else
      "Not rated"
    end
  end

end
