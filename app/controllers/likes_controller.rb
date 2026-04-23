class LikesController < ApplicationController
  before_action :set_photo

  def create
    # NOTE: find_or_create_by prevents duplicates at the application level.
    # The unique DB index on [user_id, photo_id] serves as a safety net.
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

  # TODO: Add rate limiting (e.g. rack-attack or Rails' built-in rate_limit)

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end
