class Constituency < ActiveRecord::Base
	has_one :mp
	has_many :post_codes
end
