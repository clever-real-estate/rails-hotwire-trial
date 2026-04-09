# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    current_user.likes.find_or_create_by!(photo: @photo)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    current_user.likes.find_by(photo: @photo)&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end
end