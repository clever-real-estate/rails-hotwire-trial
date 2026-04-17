module Photos
  class LikesController < ApplicationController
    before_action :set_photo

    def create
      @like = @photo.likes.new(user: current_user)

      if @like.save
        update_photos_and_respond
      end
    end

    def destroy
      @like = @photo.likes.find_by!(user: current_user)
      @like.destroy

      update_photos_and_respond
    end

    private

    def set_photo
      @photo = Photo.find(params[:photo_id])
    end

    def update_photos_and_respond
      filter = session[:photos_filter]&.to_sym || :all
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

      respond_to do |format|
        format.turbo_stream { render "photos/filter_photos" }
      end
    end
  end
end
