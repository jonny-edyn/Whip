class Bill < ActiveRecord::Base
	is_impressionable

	
	has_many :votes

	has_many :bill_issues
	has_many :issues, through: :bill_issues

	scope :with_matching_issue, ->(name = params[:issue_name]) {joins(:issues).merge(Issue.equal_to(name))}

	 Bill.joins(:issues).merge(Issue.equal_to('Arts and Culture'))
end
