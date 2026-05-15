class LikesController < ApplicationController
  before_action :set_photo

  def create
    @like = @photo.likes.build(user: current_user)
    if @like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to photos_path }
      end
    else
      redirect_to photos_path, alert: "Already liked."
    end
  end

  def destroy
    @like = @photo.likes.find_by!(user: current_user)
    @like.destroy
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