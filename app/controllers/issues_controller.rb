class IssuesController < ApplicationController
	before_action :set_bill_count, only: [:find_issues]

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
		@bills = Bill.with_matching_issue(params[:issue_name])
		count = []
		@trending = []
		@common = []
		@name = params[:issue_name]

		if Setting.first.yes

			@bills.each do |bill|
				count << [bill, bill.impressionist_count]
			end

			orderd_count = count.sort_by{|k|k[1]}.reverse

			@trending_both = orderd_count.first(3)
			@trending_both.each do |trending|
				@trending << trending[0]
			end
			@common_both = orderd_count.drop(3)
			@common_both.each do |common|
				@common << common[0]
			end
		else

			
			@bills.each do |bill|
				if bill.trending
					@trending << bill
				end
			end
			@bills.each do |bill|
				unless bill.trending
					@common << bill
				end
			end

		end
	end

	private

	  def issue_params
	  	params.require(:issue).permit(:name)
	  end

end
