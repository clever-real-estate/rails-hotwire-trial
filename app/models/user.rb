class User < ApplicationRecord
  has_secure_password
  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true

  before_save { self.email = email.downcase }
end
