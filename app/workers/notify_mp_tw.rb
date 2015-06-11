class NotifyMpTw

  @queue = :message_queue

  def self.perform(message_content, user_id)

  	user = User.find(user_id)


    require 'mandrill'
	mandrill = Mandrill::API.new "#{ENV['MANDRILL_APIKEY']}"
	message = {  
	 :subject=> "Whip User Requesting You Get Twitter",  
	 :from_name=> "#{voter.name}",  
	 :text=>"A user from Whip has requested you get Twitter

	 User Name: #{user.name}
	 Contact Email: #{user.email}

	 Comment From User: #{message_content}

	 I will be using Whip for all my political insights!",  
	 :to=>[  
	   {  
	     :email=> "test@mps.com",  
	     :name=> "My MP"  
	   }  
	 ],  
	 :html=>"<html>
	 <h2>A user from Whip has requested you get Twitter</h2><br>
	 <p>User Name: #{user.name}</p>
	 <p>Contact Email: #{user.email}</p><br>

	 <p>Comment From Voter: #{message_content}</p><br>

	 <p>I will be using Whip for all my political insights!</p>
	 </html>",  
	 :from_email=>"#{user.email}"  
	}  
	sending = mandrill.messages.send message


  rescue Resque::TermException
  	Resque.enqueue(self, key)
  end

end