class Like < ApplicationRecord
  belongs_to :user
  belongs_to :photo

  validates :user_id, uniqueness: { scope: :photo_id }

  after_create  :increment_likes
  after_destroy :decrement_likes

  private

  def increment_likes
    photo.increment!(:likes_count)
  end

  def decrement_likes
    photo.decrement!(:likes_count)
  end
end