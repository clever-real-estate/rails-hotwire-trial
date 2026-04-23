class CreatePhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :photos do |t|
      t.timestamps

      t.string :photographer_name, null: false, index: true
      t.text :original_url, null: false
      t.text :medium_url, null: false
      t.string :alt, null: false
      t.integer :photo_likes_count, null: false, default: 0, index: true
    end
  end
end
