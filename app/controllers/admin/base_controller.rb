class Admin::BaseController < ApplicationController
  before_action :check_if_admin

  def check_if_admin
    unless user_signed_in? && current_user.admin
      redirect_to root_path
    end
  end

end