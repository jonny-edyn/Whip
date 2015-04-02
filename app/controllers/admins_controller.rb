class AdminsController < ApplicationController
	before_action :check_if_admin

	def users
		@users = User.all
	end

	def bills
		@bills = Bill.all
		@bill = Bill.new
		@issues = Issue.all
		@setting = Setting.first
	end

	def parties
		@parties = Party.all
		@party = Party.new
	end

	def issues
		@issues = Issue.all
		@issue = Issue.new
	end

	def constituencies
		@constituencies = Constituency.all
	end

	def mps
		@mps = Mp.all
	end

	def post_codes
		@post_codes = PostCode.all
	end

end
