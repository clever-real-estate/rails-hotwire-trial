class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.bigint :pexels_id, null: false
      t.integer :width
      t.integer :height
      t.string :url, null: false
      t.string :photographer, null: false
      t.string :photographer_url
      t.bigint :photographer_id
      t.string :avg_color
      t.string :src_original
      t.string :src_large2x
      t.string :src_large
      t.string :src_medium, null: false
      t.string :src_small
      t.string :src_portrait
      t.string :src_landscape
      t.string :src_tiny
      t.string :alt
      t.integer :likes_count, null: false, default: 0

      t.timestamps
    end

    add_index :photos, :pexels_id, unique: true
  end
end
