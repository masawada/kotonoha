class CreateKeys < ActiveRecord::Migration
  def up
    create_table :keys do |t|
      t.references :user
      t.string :access
      t.string :secret

      t.timestamps
    end

    add_index :keys, :user_id, :unique => true
    add_index :keys, :access, :unique => true
  end

  def down
    remove_index :user
    remove_index :access

    drop_table :keys
  end
end
