class Admin::BillsController < Admin::BaseController

	def index
		@bills = Bill.includes(:media_links, :issues).all.to_a
		@bill = Bill.new
		@issues = Issue.all
		@setting = Setting.first

		@bills = Kaminari.paginate_array(@bills).page(params[:page]).per(10)

		@s3_direct_post_primary = S3_BUCKET.presigned_post(key: "uploads/bill_photos/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
	end

	def create
		@bill = Bill.new(bill_params)
		
		if @bill.save
	    	redirect_to :back
		else
	  	render 'static_pages/home'
		end
	end

	def edit
		@bill = Bill.find(params[:id])
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

	def voting_results
		@bills = Bill.all
	end

	def get_voting_results
		@web_url = params[:web_url]
		@bill_id = params[:bill_id]
		Resque.enqueue(VotesSet, @bill_id, @web_url)
		redirect_to :back
	end

	def mass_bill_import
		Bill.import(params[:file])
		redirect_to :back
	end

	private

	  def bill_params
	  	params.require(:bill).permit(:progress, :meaning, :impact, :cost, :trending, :simple_name, :official_name, :support,
	  															 :opposition, :image_url, :social_image_url)
	  end

end