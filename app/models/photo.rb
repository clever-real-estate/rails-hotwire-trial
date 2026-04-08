class Photo < ApplicationRecord
  has_many :photo_likes, dependent: :destroy
  has_many :likers, through: :photo_likes, source: :user
end
