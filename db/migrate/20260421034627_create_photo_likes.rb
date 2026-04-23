class CreatePhotoLikes < ActiveRecord::Migration[8.1]
  def change
    create_table :photo_likes do |t|
      t.timestamps
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :photo, null: false, foreign_key: true
    end

    add_index :photo_likes, [:user_id, :photo_id], unique: true
  end
end
