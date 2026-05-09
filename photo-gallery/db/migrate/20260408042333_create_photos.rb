class CreatePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :photos do |t|
      t.string :image_url
      t.string :photographer
      t.string :source_url
      t.string  :alt

      t.timestamps
    end
  end
end
