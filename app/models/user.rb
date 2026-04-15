class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo

  def likes?(photo)
    liked_photos.include?(photo)
  end
end
