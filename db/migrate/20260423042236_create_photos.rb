class CreatePhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :photos do |t|
      t.integer :external_id
      t.string :external_source
      t.string :url
      t.string :photographer
      t.string :photographer_url
      t.string :image_url
      t.string :alt

      t.timestamps
    end
  end
end
