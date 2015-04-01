class PartiesController < ApplicationController

	def create

		@party = Party.new(party_params)
		
    
	  	if @party.save
	      	redirect_to :back
	  	else
	    	render 'static_pages/home'
	  	end

	end

	def update

		@party = Party.find(params[:id])

		if @party.update_attributes(party_params)
			redirect_to :back
		else
			redirect_to :root_path
		end
		
	end

	def destroy
		
		@party = Party.find(params[:id])

		if @party.destroy!
			redirect_to :back
		else
			redirect_to :root_path
		end

	end

	private

	  def party_params
	  	params.require(:party).permit(:name)
	  end

end
