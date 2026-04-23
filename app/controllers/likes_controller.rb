class LikesController < ApplicationController
  before_action :set_photo

  def create
    current_user.likes.find_or_create_by(photo: @photo)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def destroy
    current_user.likes.find_by(photo: @photo)&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end
