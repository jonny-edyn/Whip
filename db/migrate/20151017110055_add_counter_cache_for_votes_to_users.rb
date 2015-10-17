class AddCounterCacheForVotesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :votes_count, :integer, default: 0
  end
end
