class AddCommentScoreToVotes < ActiveRecord::Migration
  def change
  	add_column :votes, :comment_score, :integer, default: 0
  end
end
