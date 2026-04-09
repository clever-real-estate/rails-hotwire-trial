class CreatePhotoLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :photo_likes do |t|
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.references :photo, null: false, foreign_key: true
    end

    add_index :photo_likes, [:user_id, :photo_id], unique: true
  end
end
