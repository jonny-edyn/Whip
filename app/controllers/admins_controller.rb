class AdminsController < ApplicationController
	before_action :check_if_admin
	skip_before_filter :check_if_admin, :only => [:hidden_admin_login]

	def users
		@users = User.all
	end

	def bills
		@bills = Bill.includes(:media_links, :issues).all.to_a
		@bill = Bill.new
		@issues = Issue.all
		@setting = Setting.first

		@bills = Kaminari.paginate_array(@bills).page(params[:page]).per(10)

		@s3_direct_post_primary = S3_BUCKET.presigned_post(key: "uploads/bill_photos/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
	end

	def parties
		@parties = Party.all
		@party = Party.new
	end

	def issues
		@issues = Issue.all
		@issue = Issue.new
	end

	def constituencies
		@constituencies = Constituency.includes(:mp).all.order(name: :asc).to_a
		@constituency_count = @constituencies.length

		@constituencies = Kaminari.paginate_array(@constituencies).page(params[:page]).per(10)

		@setting = Setting.find_by(name: 'updating_constituency_list')
	end

	def populate_constituencies
		Resque.enqueue(ConstituenciesSet)
		redirect_to :back
	end

	def mps
		@mps = Mp.includes(:constituency).all.order(name: :asc).to_a
		@mp_count = @mps.length

		@mps = Kaminari.paginate_array(@mps).page(params[:page]).per(10)

		@setting = Setting.find_by(name: 'updating_mp_list')
	end

	def populate_mps
		Resque.enqueue(MpsSet)
		redirect_to :back
	end

	def mass_mp_import
		Mp.import(params[:file])
		redirect_to :back
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

	def hidden_admin_login
		
	end

end
