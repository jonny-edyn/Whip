class Vote < ActiveRecord::Base
	belongs_to :bill
	belongs_to :voteable, polymorphic: true, counter_cache: true

	def vote_from?(user)
		voteable == user
	end

end
