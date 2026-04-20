class Photo < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :external_id, presence: true, uniqueness: true
  validates :photographer, presence: true
  validates :src_medium, presence: true

  def liked_by?(user)
    return false unless user
    likes.any? { |l| l.user_id == user.id }
  end
end
