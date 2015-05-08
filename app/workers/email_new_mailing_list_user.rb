class EmailNewMailingListUser

  @queue = :message_queue

  def self.perform(contact_email)


    require 'mandrill'
	mandrill = Mandrill::API.new "#{ENV['MANDRILL_APIKEY']}"
	message = {  
	 :subject=> "Welcome To Whip",  
	 :from_name=> "Whip Team",  
	 :text=>"Hi,

	 Thank you for your interest in Whip, we’re very grateful!

	We are currently in private beta testing our platform. We plan to launch the website on the 1st of June, until then check us out on Facebook, Twitter, Instagram and Tumblr. I​f you want to become one of our first users then send us an email at
	contact@whip.org.uk. Please find more information about Whip below.


	Who We Are

	Whip is a mission driven start-up organisation whose vision is to create the first UK civic engagement and participation platform. We are independent, non-partisan and for profit.


	Our Mission

	Whips mission is to r​evolutionise​the way we connect with and influence our government.​  W​hat if every British citizen could see and understand the bills going through westminster? What if every British citizen could express an opinion on this information ? What if every British citizen could see if their MP was listening to their opinions? In other words, what if you could have Parliament in your hands.


	Remember 1st of June!

	Thanks,
	The Whip Team",  
	 :to=>[  
	   {  
	     :email=> contact_email,  
	   }  
	 ],  
	 :html=>"<html>
	  <div style='text-align:center;border-bottom: #d2d2d2 1px solid; width:100%;'>
	  	<img style='width:35%;' src='http://www.whip.org.uk/assets/terms_image-9b756049cc502f946529767179cec2f3.png' alt='My image' />
	  </div>
	  <div>
	    <p>Hi,</p>
		<p>Thank you for your interest in Whip, we’re very grateful!</p>
		<p>We are currently in private beta testing our platform. We plan to launch the website on the 1st of June, until then check us out on Facebook, Twitter, Instagram and Tumblr. 
		I​f you want to become one of our first users then send us an email at contact@whip.org.uk. Please find more information about Whip below.</p>
		<p>Who We Are</p>
		<p>Whip is a mission driven start-up organisation whose vision is to create the first UK civic engagement and participation platform. We are independent, non-partisan and for profit.</p>
		<p>Our Mission</p>
		<p>Whips mission is to r​evolutionise​the way we connect with and influence our government.​
		W​hat if every British citizen could see and understand the bills going through westminster? 
		What if every British citizen could express an opinion on this information? 
		What if every British citizen could see if their MP was listening to their opinions? 
		In other words, what if you could have Parliament in your hands.</p>
		<p>Remember 1st of June!</p>
		<p>Thanks,</p>
		<p>The Whip Team</p>
	  </div>
	  <div style='text-align:center;border-bottom: #d2d2d2 1px solid; width:100%;'>
	  	<img style='width:35%;' src='http://www.whip.org.uk/assets/terms_image-9b756049cc502f946529767179cec2f3.png' alt='My image' />
	  </div>
	 </html>",  
	 :from_email=>"contact@whip.org.uk"  
	}  
	sending = mandrill.messages.send message


  rescue Resque::TermException
  	Resque.enqueue(self, key)
  end

end