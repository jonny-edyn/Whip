class Admin::ConstituenciesController < Admin::BaseController

	def index
		@constituencies = Constituency.includes(:mp).all.order(name: :asc).to_a
		@constituency_count = @constituencies.length

		@constituencies = Kaminari.paginate_array(@constituencies).page(params[:page]).per(10)

		@setting = Setting.find_by(name: 'updating_constituency_list')
	end

	def populate_constituencies
		Resque.enqueue(ConstituenciesSet)
		redirect_to :back
	end

end