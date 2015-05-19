class VotesController < ApplicationController
	before_action :set_idents, only: [:my_votes]
	before_action :set_bill_count, only: [:my_votes]

	def create
		unless current_user.votes.where(bill_id: params[:bill_id]).any?
			@vote = current_user.votes.build
			@vote.bill_id = params[:bill_id]
			@vote.in_favor = params[:in_favor]
			@vote.comment = params[:comment]
		else
			@vote = current_user.votes.find_by(bill_id: params[:bill_id])
			@vote.in_favor = params[:in_favor]
			@vote.comment = params[:comment]
		end

		if @vote.save
			Resque.enqueue(NewVoteMessage, @vote.id)
			respond_to do |format|
	      		format.html {redirect_to :back}
	      		format.js { render :partial => 'vote_success.js.erb' }
	      	end
	  	else
	    	render 'static_pages/home'
	  	end
	    
	end

	def my_votes

		unless user_signed_in?
			redirect_to root_path
		else
			@votes = current_user.votes
		end
		
	end

end