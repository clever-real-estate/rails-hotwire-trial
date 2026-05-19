class User < ApplicationRecord
  has_secure_password

  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
