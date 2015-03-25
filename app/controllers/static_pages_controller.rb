class StaticPagesController < ApplicationController

	def home
		@idents = []
		current_user.identities.each do |i|
			@idents << i.provider
		end
	end
end
