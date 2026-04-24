class Like < ApplicationRecord
  belongs_to :user
  belongs_to :photo, counter_cache: true
  
  validates :photo_id, uniqueness: { scope: :user_id }
end