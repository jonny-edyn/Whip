class NotifyMpFb

  @queue = :message_queue

  def self.perform(message_content, user_id)

  	user = User.find(user_id)


    require 'mandrill'
	mandrill = Mandrill::API.new "#{ENV['MANDRILL_APIKEY']}"
	message = {  
	 :subject=> "Whip User Requesting You Get Facebook",  
	 :from_name=> "#{user.name}",  
	 :text=>"A user from Whip has requested you get Facebook

	 User Name: #{user.name}
	 Contact Email: #{user.email}

	 Comment From User: #{message_content}

	 I will be using Whip for all my political insights!",  
	 :to=>[  
	   {  
	     :email=> "#{voter.constituency.mp.email}",  
	     :name=> "#{voter.constituency.mp.name}"  
	   }  
	 ],  
	 :html=>"<html>
	 	<div class='text-center' style='border-bottom: #d2d2d2 1px solid; width:100%;'>
		  	<img style='width:35%;' src='http://www.whip.org.uk/assets/terms_image-9b756049cc502f946529767179cec2f3.png' alt='My image' />
		</div>
  		<div style='width:95%;'>
			 <h2>A user from Whip has requested you get Facebook</h2><br>
			 <p>User Name: #{user.name}</p>
			 <p>Contact Email: #{user.email}</p><br>

			 <p>Comment From Voter: #{message_content}</p><br>

			 <p>I will be using Whip for all my political insights!</p>
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
	 :from_email=>"#{user.email}"  
	}  
	sending = mandrill.messages.send message


  rescue Resque::TermException
  	Resque.enqueue(self, key)
  end

end