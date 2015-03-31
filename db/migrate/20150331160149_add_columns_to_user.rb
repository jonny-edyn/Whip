class AddColumnsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :party_id, :integer
  	add_column :users, :postcode_id, :integer

  	add_column :users, :picture_url, :string
  end
end
