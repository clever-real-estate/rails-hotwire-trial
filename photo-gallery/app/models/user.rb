class User < ApplicationRecord
  has_secure_password
  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo
  validates :email, presence: true, uniqueness: true
end
