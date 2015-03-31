class CreatePostCodes < ActiveRecord::Migration
  def change
    create_table :post_codes do |t|
      t.integer :constituency_id
      t.string :number
      

      t.timestamps null: false
    end
  end
end
