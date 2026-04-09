class AddPhotoLikesCountToPhotos < ActiveRecord::Migration[8.0]
  def change
    add_column :photos, :photo_likes_count, :integer, null: false, default: 0
  end
end
