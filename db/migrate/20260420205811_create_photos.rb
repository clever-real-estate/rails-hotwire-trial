class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.string :external_id, null: false
      t.string :photographer, null: false
      t.string :photographer_url
      t.string :src_medium, null: false
      t.string :source_url
      t.string :alt

      t.timestamps
    end
    add_index :photos, :external_id, unique: true
  end
end
