class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :bill_id
      t.boolean :type
      t.references :voteable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
