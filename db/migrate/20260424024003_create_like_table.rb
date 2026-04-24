class CreateLikeTable < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :photo, null: false, foreign_key: true
      
      t.timestamps
    end
    
    add_column :photos, :likes_count, :integer, default: 0, null: false
    add_index :likes, [:user_id, :photo_id], unique: true
  end
end
