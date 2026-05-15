class Photo < ApplicationRecord
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    return false unless user
    likes.exists?(user: user)
  end
end