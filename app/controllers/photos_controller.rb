class PhotosController < ApplicationController
  def index
    set_photos_for_filter(:all)
  end

  def filter_photos
    filter = params[:filter]&.to_sym || :all
    session[:photos_filter] = filter
    set_photos_for_filter(filter)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_photos_for_filter(filter)
    @liked_photo_ids = current_user.likes.pluck(:photo_id).to_set
    @photos_view = filter

    case filter
    when :liked
      @photos = current_user.liked_photos.order(created_at: :desc)
    when :not_liked
      @photos = Photo.where.not(id: current_user.likes.select(:photo_id)).order(created_at: :desc)
    else # :all
      @photos = Photo.all.order(created_at: :desc)
    end
  end
end
