class RegistrationsController < Devise::RegistrationsController

	 # POST /resource
	def create
		build_resource(sign_up_params)
		resource.name = "#{params[:first_name]} #{params[:last_name]}" 
		resource.save
		yield resource if block_given?
		if resource.persisted?
			Resque.enqueue(EmailNewUser, resource.id)
			if resource.active_for_authentication?
				set_flash_message :notice, :signed_up if is_flashing_format?
				sign_up(resource_name, resource)
				respond_with resource, location: edit_user_path(resource)
			else
				set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
				expire_data_after_sign_in!
				respond_with resource, location: edit_user_path(resource)
			end
		else
			clean_up_passwords resource
			set_minimum_password_length
			resource.errors.full_messages.each {|x| flash[x] = x}
			session[:failed_reg] = true
			redirect_to root_path
		end
	end

	def set_minimum_password_length
		@validatable = devise_mapping.validatable?
		if @validatable
			@minimum_password_length = resource_class.password_length.min
		end
	end

end