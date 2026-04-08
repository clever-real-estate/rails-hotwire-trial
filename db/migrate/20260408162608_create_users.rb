class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :username, null: false
      t.string :password_digest, null: false
    end

    add_index :users, :username, unique: true
  end
end
