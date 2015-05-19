class SessionsController < Devise::SessionsController
	skip_before_filter :check_if_admin

	# POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def failure
  	flash[:notice] = 'Invalid Email Address Or Password!'
	respond_to do |format|
        format.html { redirect_to root_path }
      end
  end

	
end