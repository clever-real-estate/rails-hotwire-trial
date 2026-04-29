class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.string :image_url
      t.string :source_url
      t.string :photographer_name
      t.string :photographer_url
      t.text :alt_text
      t.integer :likes_count, default: 0, null: false

      t.timestamps
    end
  end
end
