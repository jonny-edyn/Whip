class AddWebIdToMps < ActiveRecord::Migration
  def change
  	add_column :mps, :web_id, :integer
  end
end
