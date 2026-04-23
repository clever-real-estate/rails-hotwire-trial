class Photo < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  # NOTE: if the photo set grows, using counter_cache on likes_count
  # to avoid N+1 COUNT queries on the index page.
end
