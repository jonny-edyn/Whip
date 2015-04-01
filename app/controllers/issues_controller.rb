class IssuesController < ApplicationController

	def create

		@issue = Issue.new(issue_params)
		
    
	  	if @issue.save
	      	redirect_to :back
	  	else
	    	render 'static_pages/home'
	  	end

	end

	def update

		@issue = Issue.find(params[:id])

		if @issue.update_attributes(issue_params)
			redirect_to :back
		else
			redirect_to :root_path
		end
		
	end

	def destroy
		
		@issue = Issue.find(params[:id])

		if @issue.destroy!
			redirect_to :back
		else
			redirect_to :root_path
		end

	end

	private

	  def issue_params
	  	params.require(:issue).permit(:name)
	  end

end
