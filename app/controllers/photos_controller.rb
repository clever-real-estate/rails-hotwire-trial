class PhotosController < ApplicationController
  def index
    @photos = Photo.alphabetical_by_photographer
    @liked_photo_ids = current_user
      .likes
      .where(photo_id: @photos.map(&:id))
      .pluck(:photo_id)
      .to_set
  end
end
