class LikesController < ApplicationController
  before_action :set_photo

  def create
    current_user.likes.find_or_create_by(photo: @photo)
    redirect_to root_path
  end

  def destroy
    current_user.likes.find_by(photo: @photo)&.destroy
    redirect_to root_path
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end
