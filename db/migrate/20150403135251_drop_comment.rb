class DropComment < ActiveRecord::Migration
  def up
    drop_table :comments
  end

  def down
    create_table :comments do |t|
      t.integer :user_id
      t.integer :bill_id
      t.text :content

      t.timestamps null: false
    end
  end
end
