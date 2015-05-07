class StaticPagesController < ApplicationController
	skip_before_filter :check_if_admin, :only => [:mailing_list_request, :prelaunch_landing_page, :home, :old_home, :privacy, :terms]

	def home

	end

	def old_home
		
	end

	def mailing_list_request
		@contact_email = params[:contact_email]

		Resque.enqueue(AddToMailingList, @contact_email)

		respond_to do |format|
			format.html {redirect_to :back}
			format.js { render :partial => 'add_user_to_mailing_list.js.erb' }
		end

	end

	def prelaunch_landing_page
		
	end

	def privacy
		
	end

	def terms
		
	end

	
end

