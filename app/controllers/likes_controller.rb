class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photo

  def create
    @like = current_user.likes.find_or_create_by!(photo: @photo)
    @photo.reload

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to photos_path }
    end
  end

  def destroy
    @like = current_user.likes.find_by!(photo: @photo).destroy
    @photo.reload

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to photos_path }
    end
  end

  private
  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end
