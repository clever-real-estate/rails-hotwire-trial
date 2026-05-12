class User < ApplicationRecord
  has_secure_password

  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  def liked?(photo)
    likes.exists?(photo_id: photo.id)
  end
end
