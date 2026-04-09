class Photo < ApplicationRecord
  has_many :photo_likes, dependent: :destroy
  has_many :likers, through: :photo_likes, source: :user

  def like_count
    photo_likes_count
  end

  def liked_by?(user)
    return false unless user

    photo_likes.exists?(user: user)
  end
end
