class Issue < ActiveRecord::Base
	has_many :bill_issues
	has_many :bills, through: :bill_issues
end
