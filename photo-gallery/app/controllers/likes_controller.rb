# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])

    current_user.likes.find_or_create_by(photo: @photo)
    @photo.likes.reload
    @liked_photo_ids = current_user.likes.pluck(:photo_id).to_set

    render partial: 'photos/like_button', locals: { photo: @photo }
  end

  def destroy
    like = current_user.likes.find(params[:id])

    @photo = like.photo

    like.destroy
    @photo.likes.reload
    @liked_photo_ids = current_user.likes.pluck(:photo_id).to_set

    render partial: 'photos/like_button', locals: { photo: @photo }
  end
end
