class CreatePhotos < ActiveRecord::Migration[7.2]
  def change
    create_table :photos, id: :integer, primary_key: :id do |t|
      t.integer :width
      t.integer :height
      t.string :url
      t.string :photographer
      t.string :photographer_url
      t.integer :photographer_id
      t.string :avg_color
      t.string :src_medium
      t.string :alt

      t.timestamps
    end
  end
end
