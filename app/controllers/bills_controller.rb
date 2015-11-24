class BillsController < ApplicationController
	after_action :update_impressions_count, only: [:show]

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



	private

	  def update_impressions_count
	  	impressionist(@bill)
	  end
	  

end
