class Photo < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  def liked_by?(user)
    likes.exists?(user: user)
  end
end
