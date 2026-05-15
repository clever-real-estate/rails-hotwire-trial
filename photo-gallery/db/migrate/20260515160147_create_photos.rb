class CreatePhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :photographer
      t.string :src_medium
      t.string :source_url
      t.integer :likes_count

      t.timestamps
    end
  end
end
