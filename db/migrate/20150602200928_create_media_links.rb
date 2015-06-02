class CreateMediaLinks < ActiveRecord::Migration
  def change
    create_table :media_links do |t|
      t.integer :bill_id
      t.string :web_url

      t.timestamps null: false
    end
  end
end
