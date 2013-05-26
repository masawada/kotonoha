class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.text :url
      t.text :bio

      t.timestamps
    end

    add_index :users, :name, :unique => true
  end

  def down
    remove_index :users

    drop_table :users
  end
end

