class ChangeColumnNameInVotes < ActiveRecord::Migration
  def change
  	rename_column :votes, :type, :in_favor
  end
end
