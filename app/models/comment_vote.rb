class CommentVote < ActiveRecord::Base
	belongs_to :user

	validates :vote_id, presence: true
 	validates :user_id, presence: true
end
