class AddCommentsToVotes < ActiveRecord::Migration
  def change
  	add_column :votes, :comment, :text
  end
end
