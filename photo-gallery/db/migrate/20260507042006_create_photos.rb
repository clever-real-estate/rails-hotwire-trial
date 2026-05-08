# frozen_string_literal: true

class CreatePhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :photos do |t|
      t.string :photographer
      t.string :source_url
      t.string :image_url

      t.timestamps
    end
  end
end
