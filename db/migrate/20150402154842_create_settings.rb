class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.boolean :yes
      t.string :name

      t.timestamps null: false
    end
  end
end
