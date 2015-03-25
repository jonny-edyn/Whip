class StaticPagesController < ApplicationController

	def home

		@idents = []

		if user_signed_in?
			current_user.identities.each do |i|
				@idents << i.provider
			end
		end

	end

	
end
