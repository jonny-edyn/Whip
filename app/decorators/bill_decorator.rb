class BillDecorator < Draper::Decorator
  delegate_all

  def set_background_img
  	if bill.image_url
			"https:#{object.image_url}"
	  else
			h.asset_path 'bill-standard-background.jpg'
		end
  end

  def set_trending_bill_link(user)
  	if user
			"<h1>#{h.link_to object.simple_name, h.bill_path(object)}</h1>
			<h3>#{h.link_to official_name_text(object), h.bill_path(object)}</h3>".html_safe
	  else
			"<a class='' href='#' data-toggle='modal' data-target='#loginModal'><h1>#{object.simple_name}</h1></a>
			<a class='' href='#' data-toggle='modal' data-target='#loginModal'><h3>#{official_name_text(object)}</h3></a>".html_safe
		end
  end

  def official_name_text(object)
  	"#{object.official_name}" + "#{' - ' + bill.issues.first.name if bill.issues.first}"
  end

  def set_link_of_subtext(user)
  	if user
			"<a href='#{h.bill_path(object)}'>".html_safe
	  else
			"<a class='' href='#' data-toggle='modal' data-target='#loginModal'>".html_safe
		end
  end

  def set_yes_vote_btn(user)
  	if user
			h.render :partial => 'bills/vote_yes_form', :locals => { :bill => object.id, :vote => false }
	  else
			"<a class='btn btn-vote-yes' href='#' data-toggle='modal' data-target='#loginModal'>VOTE YES</a>".html_safe
		end
  end

  def set_no_vote_btn(user)
  	if user
			h.render :partial => 'bills/vote_no_form', :locals => { :bill => object.id, :vote => false }
	  else
			"<a class='btn btn-vote-no' href='#' data-toggle='modal' data-target='#loginModal'>VOTE NO</a>".html_safe
		end
  end

  def set_common_bill_link(user)
  	if user
			"<a href='#{h.bill_path(object)}' class='bricks'>".html_safe
	  else
			"<a class='' href='#' data-toggle='modal' data-target='#loginModal'>".html_safe
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
