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

	def populate_constituencies
		require 'open-uri'
		encoded_url_2 = URI.encode('http://data.parliament.uk/membersdataplatform/services/mnis/ReferenceData/Constituencies/')
		@doc_2 = Nokogiri::HTML(open(encoded_url_2))
		@constituencies = []
		@doc_2.xpath("//constituency").each do |constituency|
			if constituency.xpath('enddate').text == ""
		 		@constituencies << { "name" => constituency.xpath('name').text, "constituency_web_id" => constituency.xpath('constituency_id').text}
		 	end
		end
		if @constituencies.any?
			@constituencies.each do |constituency_add|
				if Constituency.where(web_id: constituency_add['constituency_web_id']).any?
					Resque.enqueue(UpdateConstituency, constituency_add['name'], constituency_add['constituency_web_id'])
				else
					Resque.enqueue(AddConstituency, constituency_add['name'], constituency_add['constituency_web_id'])
				end
			end
		end
		redirect_to :back
	end

	def mps
		@mps = Mp.all
	end

	def post_codes
		@post_codes = PostCode.all
	end

end
