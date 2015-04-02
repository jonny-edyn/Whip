class VotesController < ApplicationController

	def create
		unless current_user.votes.where(bill_id: params[:bill_id]).any?
			@vote = current_user.votes.build
			@vote.bill_id = params[:bill_id]
			@vote.in_favor = params[:in_favor]
		else
			@vote = current_user.votes.find_by(bill_id: params[:bill_id])
			@vote.in_favor = params[:in_favor]
		end

		if @vote.save
	      	redirect_to :back
	  	else
	    	render 'static_pages/home'
	  	end
	    
	end

end