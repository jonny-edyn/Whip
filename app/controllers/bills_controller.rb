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
	end

	def show
		@bill = Bill.find(params[:id])
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
	  	params.require(:bill).permit(:progress, :meaning, :impact, :cost, :trending, :simple_name, :official_name, :support, :opposition)
	  end
	  

end
