class LikesController < ApplicationController
  before_action :require_login
  before_action :set_photo

  def create
    like = @photo.likes.find_by(user_id: current_user.id)

    if like
      like.destroy
    else
      @photo.likes.create!(user: current_user)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "photo_#{@photo.id}_like",
          partial: "photos/like_button",
          locals: {
            photo: @photo,
            liked: @photo.likes.exists?(user_id: current_user.id),
            like_count: @photo.likes.count
          }
        )
      end
      format.html { redirect_to photos_path }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end
