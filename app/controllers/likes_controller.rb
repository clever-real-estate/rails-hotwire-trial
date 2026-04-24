class LikesController < ApplicationController
  before_action :find_photo
  
  def create
    current_user.likes.create!(photo: @photo)
    render partial: "photos/photo", locals: { photo: @photo }
  end
  
  def destroy
    like = @photo.likes.find_by(user_id: current_user.id)
    like&.destroy

    render partial: "photos/photo", locals: { photo: @photo }
  end
  
  private
  
  def find_photo
    @photo = Photo.find(params[:photo_id])
  end
end
