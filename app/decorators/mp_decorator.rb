class MpDecorator < Draper::Decorator
  delegate_all

  def show_email_icon
  	if object.email != ""
  		h.render :partial => 'mps/show_mp_email_icon'
  	end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
