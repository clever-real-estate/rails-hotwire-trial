class LikesController < ApplicationController
  before_action :set_photo

  def create
    # find_or_create_by! is idempotent: a double-click from the same user is a
    # no-op rather than a 422 from the uniqueness validation.
    current_user.likes.find_or_create_by!(photo: @photo)
    respond_with_card
  end

  def destroy
    current_user.likes.find_by(photo: @photo)&.destroy
    respond_with_card
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end

  def respond_with_card
    @photo.reload
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          helpers.dom_id(@photo, :like_button),
          partial: "photos/like_button",
          locals: { photo: @photo, liked: @photo.liked_by?(current_user) }
        )
      }
      format.html { redirect_to photos_path }
    end
  end
end
