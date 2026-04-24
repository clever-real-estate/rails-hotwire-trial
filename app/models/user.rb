class User < ApplicationRecord
  has_secure_password
  has_many :likes
  validates :email, presence: true, uniqueness: true
end
 