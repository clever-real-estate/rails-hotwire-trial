class PhotosController < ApplicationController
  def index
    @photos = Photo.includes(:likes).order(:id)
  end
end
