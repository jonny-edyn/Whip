class PartiesController < ApplicationController

	def create

		@party = Party.new(party_params)
		
    
	  	if @party.save
	      	redirect_to :back
	  	else
	    	render 'static_pages/home'
	  	end

	end

	private

	  def party_params
	  	params.require(:party).permit(:name)
	  end

end
