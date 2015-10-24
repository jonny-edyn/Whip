class Issue < ActiveRecord::Base
	has_many :bill_issues
	has_many :bills, through: :bill_issues

	def self.equal_to(name)
    	where("name = ?", name)
 	end
end
