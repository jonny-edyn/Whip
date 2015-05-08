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

	Whips mission is to r​evolutionise​the way we connect with and influence our government.​  W​hat if every British citizen could see and understand the bills going through Westminster? What if every British citizen could express an opinion on this information ? What if every British citizen could see if their MP was listening to their opinions? In other words, what if you could have Parliament in your hands.


	Remember 1st of June!

	Thanks,
	The Whip Team",  
	 :to=>[  
	   {  
	     :email=> contact_email,  
	   }  
	 ],  
	 :html=>"<html>
	  <div style='text-align:center; width:100%;'>
	  	<img style='width:35%;' src='http://www.whip.org.uk/assets/terms_image-9b756049cc502f946529767179cec2f3.png' alt='My image' />
	  </div>
	  <div style='width:95%;'>
	    <p>Hi,</p>
		<p>Thank you for your interest in Whip, we’re very grateful!</p>
		<p>We are currently in private beta testing our platform. We plan to launch the website on the 1st of June, until then check us out on Facebook, Twitter, Instagram and Tumblr. 
		I​f you want to become one of our first users then send us an email at contact@whip.org.uk. Please find more information about Whip below.</p>
		<p><b><u>Who We Are</u></b></p>
		<p>Whip is a mission driven start-up organisation whose vision is to create the first UK civic engagement and participation platform. We are independent, non-partisan and for profit.</p>
		<p><b><u>Our Mission</u></b></p>
		<p>Whips mission is to r​evolutionise​ the way we connect with and influence our government.​
		W​hat if every British citizen could see and understand the bills going through Westminster? 
		What if every British citizen could express an opinion on this information? 
		What if every British citizen could see if their MP was listening to their opinions? 
		In other words, what if you could have Parliament in your hands.</p>
		<p>Remember 1st of June!</p>
		<p>Thanks,</p>
		<p>The Whip Team</p>
	  </div>

	  <div style='text-align:center; width:100%;'>
	  	<img style='width:35%;' src='http://www.whip.org.uk/assets/bottom_of_email_logo-8d574e6e6f6a05c17b108297719e75b1.png' alt='My image' />
	  </div>



	 <div style='text-align:center; width:100%;'>
	 	<div style='width: auto;display:inline-block;padding: 10px;'>
			<a href='https://www.facebook.com/whipuk' target='_blank'><img src='http://www.whip.org.uk/assets/fb_icon-77e79838462dfb06153ec7dba9dd1301.png'></a>
		</div>
		<div style='width: auto;display:inline-block;padding: 10px;'>
			<a href='https://twitter.com/whipuk' target='_blank'><img src='http://www.whip.org.uk/assets/tw_icon-9e3911be9aa26638ea6aec45da76187b.png'></a>
		</div>
		<div style='width: auto;display:inline-block;padding: 10px;'>
			<a href='https://instagram.com/whipuk/' target='_blank'><img src='http://www.whip.org.uk/assets/insta_icon-815ef56e006ac03a77335fcb9ee52197.png'></a>
		</div>
		<div style='width: auto;display:inline-block;padding: 10px;'>
			<a href='https://www.youtube.com/channel/UCdt6hdrjwrRB9hLzvUdl5Lw' target='_blank'><img src='http://www.whip.org.uk/assets/youtube_icon-1f5090b500f609279a516bbdf25dcfb3.png'></a>
		</div>
		<div style='width: auto;display:inline-block;padding: 10px;'>
			<a href='http://whipuk.tumblr.com/' target='_blank'><img src='http://www.whip.org.uk/assets/tumblr_icon-4f35e3c96f52b9416a6f1532e4217b85.png'></a>
		</div>
	 </div>
	



	  <div style='text-align:center; width:100%;'>
	  	<img style='width:35%;' src='http://www.whip.org.uk/assets/bottom_of_email_address-94f5a19f70f2e0cacd03dac6700d05e8.png' alt='My image' />
	  </div>

	 </html>",  
	 :from_email=>"contact@whip.org.uk"  
	}  
	sending = mandrill.messages.send message


  rescue Resque::TermException
  	Resque.enqueue(self, key)
  end

end