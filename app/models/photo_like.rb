class PhotoLike < ApplicationRecord
  belongs_to :user
  belongs_to :photo, counter_cache: true

  validates :user_id, uniqueness: { scope: :photo_id, message: "has already liked this photo" }
end
