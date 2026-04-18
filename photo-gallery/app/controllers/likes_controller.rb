class LikesController < ApplicationController
  before_action :set_photo

  def create
    Current.user.likes.find_or_create_by!(photo: @photo)
    render_toggle(liked: true)
  end

  def destroy
    Current.user.likes.where(photo: @photo).destroy_all
    render_toggle(liked: false)
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end

  def render_toggle(liked:)
    @photo.reload
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          helpers.dom_id(@photo, :like_button),
          partial: "photos/like_button",
          locals: { photo: @photo, liked: liked }
        )
      end
      format.html { redirect_back fallback_location: photos_path }
    end
  end
end
