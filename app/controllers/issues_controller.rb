class IssuesController < ApplicationController

	def find_issues
		@bills = Bill.get_index_bills(current_user, params[:issue_name])
		trending_setting = Setting.first.yes
		@trending = BillDecorator.decorate_collection(Bill.set_trending_bills(@bills, trending_setting))
		@common = BillDecorator.decorate_collection(Bill.set_common_bills(@bills, trending_setting))

		@name = params[:issue_name]


		@commons = Kaminari.paginate_array(@common).page(params[:page]).per(20)
	end

end
