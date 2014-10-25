class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username,        null: false
      t.string :hashed_password, null: false
      t.string :email,           null: false
      t.string :full_name
      t.boolean :admin,          null: false, default: false

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
