class Photo < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  def liked_by?(user)
    likes.where(user: user).exists?
  end
end
