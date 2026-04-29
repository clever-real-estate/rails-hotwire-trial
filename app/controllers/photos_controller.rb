class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @photos = Photo.all
  end
end
