class PhotosController < ApplicationController
  before_action :require_login

  def index
    @photos = Photo.order(:id).to_a
    photo_ids = @photos.map(&:id)

    @liked_photo_ids = current_user.likes.where(photo_id: photo_ids).pluck(:photo_id)
    @like_counts = Like.where(photo_id: photo_ids).group(:photo_id).count
  end
end
