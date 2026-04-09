class CreatePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :photos do |t|
      t.bigint :external_id, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.text :url, null: false
      t.string :photographer, null: false
      t.text :photographer_url, null: false
      t.bigint :photographer_id, null: false
      t.string :avg_color, null: false
      t.text :src_original, null: false
      t.text :src_large2x, null: false
      t.text :src_large, null: false
      t.text :src_medium, null: false
      t.text :src_small, null: false
      t.text :src_portrait, null: false
      t.text :src_landscape, null: false
      t.text :src_tiny, null: false
      t.string :alt, null: false
      t.timestamps
    end

    add_index :photos, :external_id, unique: true
  end
end
