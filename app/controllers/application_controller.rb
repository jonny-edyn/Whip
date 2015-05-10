class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :set_issues
  before_action :check_if_admin 


  def layout_by_resource
    if controller_name == 'static_pages' && action_name == 'prelaunch_landing_page'
      "blank"
    elsif controller_name == 'static_pages' && action_name == 'home'
      "blank"
    elsif controller_name == 'static_pages' && action_name == 'terms'
      "blank"
    elsif controller_name == 'static_pages' && action_name == 'privacy'
      "blank"
    elsif controller_name == 'bills' && action_name == 'index'
      "application"
    elsif controller_name == 'bills' && action_name == 'show'
      "application"
    else
      "application"
    end
  end


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

    def set_idents
      @idents = []

      if user_signed_in?
        current_user.identities.each do |i|
          @idents << i.provider
        end
      end
    end

    def set_bill_count
      @votes_count = current_user.votes.count
    end

    def set_issues
      @first_issue_group = Issue.first(4)
      @second_issue_group = Issue.offset(4).first(4)
      @third_issue_group = Issue.offset(8).first(4)
      @fourth_issue_group = Issue.offset(12).first(4)
    end

end
