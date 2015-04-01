class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  	def check_if_admin
      unless user_signed_in? && current_user.admin
        redirect_to root_path
      end
    end

    def check_if_signed_in
      unless user_signed_in?
        redirect_to root_path
      end
    end

end
