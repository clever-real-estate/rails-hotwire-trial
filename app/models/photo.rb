class Photo < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :owner, :image_url, :source_url, presence: true

  def liked_by?(user)
    liking_users.include?(user)
  end

  def likes_count
    likes.size
  end
end
