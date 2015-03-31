class Mp < ActiveRecord::Base
	belongs_to :constituency
	has_many :votes, as: :voteable
end
