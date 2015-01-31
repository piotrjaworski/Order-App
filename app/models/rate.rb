class Rate < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :user
  belongs_to :restaurant
  belongs_to :product

  validates :score, presence: true

  Scores = %w[1 2 3 4 5]

  def show_score
    score = self.score.to_i
    difference = 5 - score
    if score > 0
      if difference > 0
        ("<i class='fa fa-star'></i>" * score + "<i class='fa fa-star-o'></i>" * difference).html_safe
      else
        ("<i class='fa fa-star'></i>" * score).html_safe
      end
    else
      "Not rated"
    end
  end

end
