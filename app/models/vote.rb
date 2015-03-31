class Vote < ActiveRecord::Base
	belongs_to :bill
	belongs_to :voteable, polymorphic: true
end
