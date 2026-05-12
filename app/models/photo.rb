class Photo < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  HTTP_URL = %r{\Ahttps?://[^\s]+\z}i.freeze

  validates :pexels_id, presence: true, uniqueness: true
  validates :url, :src_medium, :photographer, presence: true
  validates :url, :src_medium, format: { with: HTTP_URL }, allow_nil: true

  scope :alphabetical_by_photographer, -> { order(:photographer, :id) }

  def liked_by?(user)
    return false unless user

    likes.exists?(user_id: user.id)
  end
end
