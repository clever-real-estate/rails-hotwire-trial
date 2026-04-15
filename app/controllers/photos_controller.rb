class PhotosController < ApplicationController
  def index
    @photos = Photo.all.order(created_at: :desc)
    @liked_photo_ids = current_user.likes.pluck(:photo_id).to_set
  end
end
