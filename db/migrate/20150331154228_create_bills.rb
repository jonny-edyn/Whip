class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :progress
      t.text :meaning
      t.text :impact
      t.text :cost
      t.boolean :trending, default: false
      t.string :simple_name
      t.string :official_name
      t.text :support
      t.text :opposition


      t.timestamps null: false
    end
  end
end
