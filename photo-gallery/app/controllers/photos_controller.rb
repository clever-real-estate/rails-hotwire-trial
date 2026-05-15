class PhotosController < ApplicationController
  def index
    @photos = Photo.all.order(:id)
  end
end