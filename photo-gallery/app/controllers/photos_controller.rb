class PhotosController < ApplicationController
  def index
    @photos = Photo.includes(:likes)
    @liked_photo_ids = current_user.likes.where(photo_id: @photos.select(:id)).pluck(:photo_id)
  end
end
