class Like < ApplicationRecord
  belongs_to :user
  belongs_to :photo, counter_cache: true

  validates :user_id, uniqueness: { scope: :photo_id }

  after_commit :broadcast_like_count

  private

  # Broadcast only the count, not the filled/outline star: the star state is
  # per-viewer, but the count is global.
  def broadcast_like_count
    fresh_photo = photo.reload
    Turbo::StreamsChannel.broadcast_replace_to(
      "photos",
      target: ActionView::RecordIdentifier.dom_id(fresh_photo, :like_count),
      partial: "photos/like_count",
      locals: { photo: fresh_photo }
    )
  end
end
