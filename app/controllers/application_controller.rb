class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :set_issues
  before_action :check_email_format
  before_action :set_user_mp

  def layout_by_resource
    if controller_name == 'static_pages' && action_name == 'prelaunch_landing_page'
      "blank"
    elsif controller_name == 'static_pages' && action_name == 'home'
      "blank"
    else
      "application"
    end
  end


  def check_if_signed_in
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def set_issues
    issues = Issue.all.to_a
    @first_issue_group = issues[0..3]
    @second_issue_group = issues[4..7] || []
    @third_issue_group = issues[8..11] || []
    @fourth_issue_group = issues[12..15] || []
  end

  def check_email_format
    if user_signed_in? && current_user.email =~ /\Achange@me/
      redirect_to finish_signup_path(current_user)
    end
  end

  def set_user_mp
    @mp = Mp.find_mp_for(current_user)
  end

end
