class CreateLeaves < ActiveRecord::Migration
  def up
    create_table :leaves do |t|
      t.text :text
      t.references :user
      t.integer :favorites, :default => 0

      t.timestamps
    end
  end

  def down
    drop_table :leaves
  end
end

