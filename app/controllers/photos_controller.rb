class PhotosController < ApplicationController
  def index
    @photos = Photo.all.order(created_at: :desc)
  end
end
