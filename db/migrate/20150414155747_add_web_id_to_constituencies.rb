class AddWebIdToConstituencies < ActiveRecord::Migration
  def change
  	add_column :constituencies, :web_id, :integer
  end
end
