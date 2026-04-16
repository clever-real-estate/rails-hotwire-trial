class LikesController < ApplicationController
  before_action :set_photo

  def create
    @photo.likes.create!(user: current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, notice: "Photo liked." }
    end
  end

  def destroy
    @photo.likes.find_by!(user: current_user).destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, notice: "Photo unliked." }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end