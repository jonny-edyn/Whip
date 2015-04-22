class BillsController < ApplicationController
	before_action :set_idents, only: [:index]
	before_action :set_bill_count, only: [:index, :show]

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
			redirect_to :back
		else
			redirect_to :root_path
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


		@bills = Bill.all
		count = []
		@trending = []
		@common = []

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

	def xls_index
		@bills = Bill.all
		respond_to do |format|
		    format.xls { send_data @bills.to_csv(col_sep: "\t") }
		end
	end

	def show
		@bill = Bill.find(params[:id])
		impressionist(@bill)
		@issues = @bill.issues
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
	  	params.require(:bill).permit(:progress, :meaning, :impact, :cost, :trending, :simple_name, :official_name, :support, :opposition, :image_url)
	  end
	  

end
