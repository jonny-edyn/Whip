class AddViewableToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :allow_profile_view, :boolean, default: false
  end
end
