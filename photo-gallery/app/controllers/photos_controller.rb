# frozen_string_literal: true

class PhotosController < ApplicationController
  def index
    @photos = Photo.includes(:likes).all
    @liked_photo_ids = current_user.likes.pluck(:photo_id).to_set
  end
end
