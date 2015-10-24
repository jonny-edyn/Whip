class BillsController < ApplicationController
	after_action :update_impressions_count, only: [:show]

	def create

		@bill = Bill.new(bill_params)
		
    
	  	if @bill.save
	      	redirect_to :back
	  	else
	    	render 'static_pages/home'
	  	end

	end

	def update

		@bill = Bill.find(params[:id])

		if @bill.update_attributes(bill_params)
			respond_to do |format|
				format.html { redirect_to :back }
				format.js { render :partial => 'edit_bill_success.js.erb' }
			end
		else
			respond_to do |format|
				format.html { redirect_to :root_path }
				format.js { render :partial => 'edit_bill_fail.js.erb' }
			end
		end
		
	end

	def destroy
		
		@bill = Bill.find(params[:id])

		if @bill.destroy!
			redirect_to :back
		else
			redirect_to :root_path
		end

	end

	def index

		@failed = true if session[:failed_reg]
		session[:failed_reg] = nil

		@bills = Bill.get_index_bills(current_user)
		trending_setting = Setting.first.yes
		@trending = BillDecorator.decorate_collection(Bill.set_trending_bills(@bills, trending_setting))
		@common = BillDecorator.decorate_collection(Bill.set_common_bills(@bills, trending_setting))

		@commons = Kaminari.paginate_array(@common).page(params[:page]).per(20)

		respond_to do |format|
			format.html
			format.js
		  format.xls { send_data @bills.to_csv(col_sep: "\t") }
		end
		
	end

	def show
		@bill = Bill.includes(:media_links, :issues).find(params[:id]).decorate
		
		@vote = @bill.get_user_vote(current_user)
		@votes = @bill.commented_votes

		@votes_top_3_yes = @bill.top_comments(3)
		@votes_top_3_no = @bill.top_comments(3, false)

		respond_to do |format|
			format.html
			format.json { render :json => @bill }
		end

	end

	def add_issues
		@bill = Bill.find(params[:id])
		@bill.issues.clear
		@issues = params[:bill_issues]

		if @issues.any?
			@issues.each do |issue|
				@bill.bill_issues.create!(issue_id: issue)
			end
		end

		respond_to do |format|
	      format.html { redirect_to :back }
	      format.js
	    end

	end

	private

	  def bill_params
	  	params.require(:bill).permit(:progress, :meaning, :impact, :cost, :trending, :simple_name, :official_name, :support, :opposition, :image_url, :social_image_url)
	  end

	  def update_impressions_count
	  	impressionist(@bill)
	  end
	  

end
