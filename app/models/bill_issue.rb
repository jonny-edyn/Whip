class BillIssue < ActiveRecord::Base
	belongs_to :bill
 	belongs_to :issue

 	validates :bill_id, presence: true
 	validates :issue_id, presence: true
end
