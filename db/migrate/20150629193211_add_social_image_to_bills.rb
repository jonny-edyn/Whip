class AddSocialImageToBills < ActiveRecord::Migration
  def change
  	add_column :bills, :social_image_url, :string
  end
end
