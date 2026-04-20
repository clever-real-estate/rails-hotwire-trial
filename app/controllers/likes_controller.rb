class LikesController < ApplicationController
  before_action :set_photo, only: [:create]
  before_action :set_like,  only: [:destroy]

  def create
    @like = current_user.likes.build(photo: @photo)
    if @like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to photos_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_to photos_path }
      end
    end
  end

  def destroy
    @photo = @like.photo
    @like.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to photos_path }
    end
  end

  private

  def set_photo
    @photo = Photo.includes(:likes).find(params[:photo_id])
  end

  def set_like
    @like = current_user.likes.includes(photo: :likes).find(params[:id])
  end
end
