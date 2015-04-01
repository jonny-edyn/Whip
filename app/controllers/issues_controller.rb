class IssuesController < ApplicationController

	def create

		@issue = Issue.new(issue_params)
		
    
	  	if @issue.save
	      	redirect_to :back
	  	else
	    	render 'static_pages/home'
	  	end

	end

	private

	  def issue_params
	  	params.require(:issue).permit(:name)
	  end

end
