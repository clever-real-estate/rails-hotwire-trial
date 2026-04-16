class Photo < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like_count
    likes.size
  end
end