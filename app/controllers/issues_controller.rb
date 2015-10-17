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

	def find_issues
		@bills = Bill.get_index_bills(current_user, params[:issue_name])
		trending_setting = Setting.first.yes
		@trending = Bill.set_trending_bills(@bills, trending_setting)
		@common = Bill.set_common_bills(@bills, trending_setting)

		@name = params[:issue_name]


		@commons = Kaminari.paginate_array(@common).page(params[:page]).per(20)
	end

	private

	  def issue_params
	  	params.require(:issue).permit(:name)
	  end

end
