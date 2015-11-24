class Vote < ActiveRecord::Base
	belongs_to :bill
	belongs_to :voteable, polymorphic: true, counter_cache: true

	validates :bill_id, presence: true
	validates :voteable_id, presence: true
	validates :voteable_type, presence: true

	def vote_from?(user)
		voteable == user
	end

end
