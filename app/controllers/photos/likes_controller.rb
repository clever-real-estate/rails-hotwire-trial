class Photos::LikesController < ApplicationController
  before_action :set_photo

  def create
    @photo.photo_likes.find_or_create_by(user: current_user)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(helpers.dom_id(@photo, :like), partial: "photos/like_button", locals: { photo: @photo }) }
      format.html { redirect_to root_path }
    end
  end

  def destroy
    @photo.photo_likes.where(user: current_user).destroy_all
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(helpers.dom_id(@photo, :like), partial: "photos/like_button", locals: { photo: @photo }) }
      format.html { redirect_to root_path }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id] || params[:id])
  end    
end