class PhotosController < ApplicationController
  def index
    @photos = Photo.order(:id)
    @liked_ids = Current.user.liked_photos.ids.to_set
  end
end
