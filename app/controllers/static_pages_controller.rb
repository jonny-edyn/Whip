class StaticPagesController < ApplicationController

	def home
		
	end

	def mailing_list_request
		@contact_email = params[:contact_email]

		Resque.enqueue(AddToMailingList, @contact_email)
		redirect_to :back
	end

	
end

