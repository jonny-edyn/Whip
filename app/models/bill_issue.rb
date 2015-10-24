class BillIssue < ActiveRecord::Base
	belongs_to :bill
 	belongs_to :issue
end
