class PhotosController < ApplicationController
  def index
    @photos = Photo.includes(:photo_likes).all
  end
end
