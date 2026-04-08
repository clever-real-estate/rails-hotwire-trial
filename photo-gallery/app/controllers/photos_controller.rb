class PhotosController < ApplicationController
  def index
    Photo.all
  end
end
