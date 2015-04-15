class AddPostCodesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :constituency_id, :integer
  	add_column :users, :post_code, :string
  end
end
