class AddBioColumsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :bio, :text
  	add_column :users, :fb_link, :string
  	add_column :users, :tw_link, :string
  	add_column :users, :insta_link, :string
  	add_column :users, :youtube_link, :string
  	add_column :users, :web_link, :string
  	add_column :users, :street_addr, :string
  	add_column :users, :city, :string
  	add_column :users, :phone, :string
  end
end
