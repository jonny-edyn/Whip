class AddImageUrlToBills < ActiveRecord::Migration
  def change
  	add_column :bills, :image_url, :string
  end
end
