class EmailNewUser

  @queue = :message_queue

  def self.perform(user_id)

  	contact_email = User.find(user_id).email

    require 'mandrill'
	mandrill = Mandrill::API.new "#{ENV['MANDRILL_APIKEY']}"
	message = {  
	 :subject=> "Welcome To Whip",  
	 :from_name=> "Whip Team",  
	 :text=>"Hi,

	 Thank you for signing up to Whip, we’re very grateful!

We have now launched our public beta. We will updating the platform over the coming weeks which we are very excited about so keep your eyes peeled.

If you have any questions or have any feedback send us an email at contact@whip.org.uk. You can keep updated by following us on Facebook, Twitter, Instagram and Tumblr. Please find more information about Whip below.

Who We Are

Whip is a mission driven start-up organization with a vision is to create the first UK civic engagement and participation platform.

What We Do 

Whip is a web platform which makes engaging in the political sphere easy, empowering users with tools to directly influence MPs and hold them to account. We give you...

	1.	Clear synthesized summaries of legislation.  
	2.	The ability to easily tell your MP how to vote.  
	3.	Tools to see if your MP voted in accordance to you, so you can hold them to account. 

Our Mission

Whip’s mission is to revolutionize the way we connect with and influence Parliament. What if every British citizen could see and understand the legislation going through Westminster? What if every British citizen could express an opinion on this information? What if every British citizen could see if their MP was listening to their opinions?

In other words, what if you could have Parliament in your hands.

Thanks, 
The Whip Team",  
	 :to=>[  
	   {  
	     :email=> contact_email,  
	   }  
	 ],  
	 :html=>"<html>
	  <div class='text-center' style='border-bottom: #d2d2d2 1px solid; width:100%;'>
	  	<img style='width:35%;' src='http://www.whip.org.uk/assets/terms_image-9b756049cc502f946529767179cec2f3.png' alt='My image' />
	  </div>
	  <div style='width:95%;'>
	    <p>Hi,</p>
		<p>Thank you for signing up to Whip, we’re very grateful!</p>
		<p>We have now launched our public beta. We will updating the platform over the coming weeks which we are very excited about so keep your eyes peeled.</p>
		<p>If you have any questions or have any feedback send us an email at contact@whip.org.uk. You can keep updated by following us on <a href='https://www.facebook.com/whipuk' target='_blank'>Facebook</a>, <a href='https://twitter.com/whipuk' target='_blank'>Twitter</a>, <a href='https://instagram.com/whipuk/' target='_blank'>Instagram</a> and <a href='http://whipuk.tumblr.com/' target='_blank'>Tumblr</a>. Please find more information about Whip below.</p>
		<p><b><u>Who We Are</u></b></p>
		<p>Whip is a mission driven start-up organization with a vision is to create the first UK civic engagement and participation platform.</p>
		<p><b><u>What We Do</u></b></p>
		<p>Whip is a web platform which makes engaging in the political sphere easy, empowering users with tools to directly influence MPs and hold them to account. We give you...</p>
		<p>1.	Clear synthesized summaries of legislation.</p>
		<p>2.	The ability to easily tell your MP how to vote.</p> 
		<p>3.	Tools to see if your MP voted in accordance to you, so you can hold them to account.</p>
		<p>Our Mission</p>
		<p>Whip’s mission is to revolutionize the way we connect with and influence Parliament. What if every British citizen could see and understand the legislation going through Westminster? What if every British citizen could express an opinion on this information? What if every British citizen could see if their MP was listening to their opinions?</p>
		<p>In other words, what if you could have Parliament in your hands.</p>
		<p>Remember 1st of June!</p>
		<p>Thanks,</p>
		<p>The Whip Team</p>
	  </div>

	  <div class='text-center' style='width:100%;margin-top:40px;'>
	  	<img style='width:35%;' src='http://www.whip.org.uk/assets/bottom_of_email_logo-8d574e6e6f6a05c17b108297719e75b1.png' alt='My image' />
	  </div>



	 <div class='text-center' style='twidth:100%;'>
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
	



	  <div class='text-center' style='width:100%;'>
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