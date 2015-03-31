class CreateMps < ActiveRecord::Migration
  def change
    create_table :mps do |t|
      t.integer :constituency_id
      t.string :fb_link
      t.string :tw_link
      t.string :email
      t.string :name
      t.string :phone
      t.string :picture_url

      t.timestamps null: false
    end
  end
end
