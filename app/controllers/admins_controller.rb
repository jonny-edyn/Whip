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
		@setting = Setting.find_by(name: 'updating_constituency_list')
	end

	def populate_constituencies
		Resque.enqueue(ConstituenciesSet)
		redirect_to :back
	end

	def mps
		@mps = Mp.all
		@setting = Setting.find_by(name: 'updating_mp_list')
	end

	def populate_mps
		Resque.enqueue(MpsSet)
		redirect_to :back
	end

	def voting_results
		@bills = Bill.all
	end

	def get_voting_results
		@web_url = params[:web_url]
		@bill_id = params[:bill_id]
		Resque.enqueue(VotesSet, @bill_id, @web_url)
		redirect_to :back
	end

	def mass_bill_import
		Bill.import(params[:file])
		redirect_to :back
	end

end
