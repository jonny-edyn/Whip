class MediaLinksController < ApplicationController

	def create
		@bill = Bill.find(params[:media_link][:bill_id])
	    @media_link = @bill.media_links.build(media_link_params)
		
    
	  	if @media_link.save
	      	redirect_to :back
	  	else
	    	render 'static_pages/home'
	  	end
	end

	def update
		@media_link = MediaLink.find(params[:id])
		
    
	  	if @media_link.update_attributes(media_link_params)
	      	redirect_to :back
	  	else
	    	render 'static_pages/home'
	  	end
	end

	def destroy
		@media_link = MediaLink.find(params[:id])

		if @media_link.destroy!
			redirect_to :back
		else
			redirect_to :root_path
		end
	end

	private

	  def media_link_params
	  	params.require(:media_link).permit(:web_url, :bill_id)
	  end

end
