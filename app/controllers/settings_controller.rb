class SettingsController < ApplicationController

	def update

		@setting = Setting.find(params[:id])

		if @setting.update_attributes(setting_params)
			redirect_to :back
		else
			redirect_to :root_path
		end
		
	end

	private

	  def setting_params
	  	params.require(:setting).permit(:name, :yes)
	  end

end
