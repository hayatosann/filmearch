class Product < ApplicationRecord
  has_many :reviews
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  def review_average
    reviews.average(:rate).round
  end
end
