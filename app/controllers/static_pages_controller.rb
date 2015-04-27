class StaticPagesController < ApplicationController

	def home

	end

	def mailing_list_request
		@contact_email = params[:contact_email]

		Resque.enqueue(AddToMailingList, @contact_email)

		respond_to do |format|
			format.html redirect_to :back
			format.js { render :partial => 'add_user_to_mailing_list.js.erb' }
		end
	end

	
end

