class CreatePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :photographer_name
      t.string :image_url
      t.string :source_url
      t.integer :likes_count, default: 0, null: false

      t.timestamps
    end
  end
end
