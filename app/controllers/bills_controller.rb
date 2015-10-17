class BillsController < ApplicationController

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
		@trending = Bill.set_trending_bills(@bills, trending_setting)
		@common = Bill.set_common_bills(@bills, trending_setting)

		@commons = Kaminari.paginate_array(@common).page(params[:page]).per(20)

		respond_to do |format|
			format.html
			format.js
		  format.xls { send_data @bills.to_csv(col_sep: "\t") }
		end
		
	end

	def show
		@bill = Bill.find(params[:id])
		impressionist(@bill)
		
		@media_links = @bill.media_links
		@issues = @bill.issues
		@vote = current_user.votes.where(bill_id: @bill.id).first if user_signed_in?
		@votes = @bill.votes.order(comment_score: :desc).where("comment != ?", "")
		@votes_top_3_yes = @bill.votes.where(in_favor: true).where("comment != ?", "").order(comment_score: :desc).first(3)
		@votes_top_3_no = @bill.votes.where(in_favor: false).where("comment != ?", "").order(comment_score: :desc).first(3)

		@for = false
		@against = false
		if @vote && @vote.in_favor
			@for = true
		end
		if @vote
			unless @vote.in_favor
				@against = true
			end
		end

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
	  

end
