class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true

  has_many :photo_likes, dependent: :destroy
  has_many :liked_photos, through: :photo_likes, source: :photo
end
