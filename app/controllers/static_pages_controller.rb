class StaticPagesController < ApplicationController

	def home
		@user = "Weir, Mr Mike".gsub('rh', '').gsub(/\s+/, ' ')
	end

	
end

