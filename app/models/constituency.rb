class Constituency < ActiveRecord::Base
	has_one :mp
	has_many :users
end
