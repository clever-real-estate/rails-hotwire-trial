class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    if like.save
      redirect_to root_path
    end
  end
  
  def destroy
    like = Like.find(params[:id])
    like.destroy if like.user_id == current_user.id
    redirect_to root_path
  end
  
  private
  
  def like_params
    params.expect(like: [:user_id, :photo_id])
  end
end
