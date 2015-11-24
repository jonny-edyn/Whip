class Admin::MpsController < Admin::BaseController

	def index
		@mps = Mp.includes(:constituency).all.order(name: :asc).to_a
		@mp_count = @mps.length

		@mps = Kaminari.paginate_array(@mps).page(params[:page]).per(10)

		@setting = Setting.find_by(name: 'updating_mp_list')

		respond_to do |format|
			format.html
			format.xls { send_data @mps.to_csv(col_sep: "\t") }
		end
	end

	def populate_mps
		Resque.enqueue(MpsSet)
		redirect_to :back
	end

	def mass_mp_import
		Mp.import(params[:file])
		redirect_to :back
	end

end