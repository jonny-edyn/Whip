class MpsController < ApplicationController
	def index
		@mps = Mp.all

		respond_to do |format|
			format.xls { send_data @mps.to_csv(col_sep: "\t") }
		end
	end
end
