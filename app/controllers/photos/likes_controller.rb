module Photos
  class LikesController < ApplicationController
    before_action :set_photo

    def create
      @like = @photo.likes.new(user: current_user)

      if @like.save
        respond_to do |format|
          format.turbo_stream
        end
      end
    end

    def destroy
      @like = @photo.likes.find_by!(user: current_user)
      @like.destroy

      respond_to do |format|
        format.turbo_stream
      end
    end

    private

    def set_photo
      @photo = Photo.find(params[:photo_id])
    end
  end
end
