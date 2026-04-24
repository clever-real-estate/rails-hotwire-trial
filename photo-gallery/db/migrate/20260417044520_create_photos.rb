class CreatePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :photos do |t|
      t.string :photographer
      t.string :src_medium
      t.string :source_url
      t.string :alt
      t.integer :likes_count, default: 0, null: false

      t.timestamps
    end
  end
end
