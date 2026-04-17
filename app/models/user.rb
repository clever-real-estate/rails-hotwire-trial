class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo

  def likes?(photo)
    likes.exists?(photo: photo)
  end
end
