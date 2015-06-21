class NewVoteMessage

  @queue = :message_queue

  def self.perform(vote_id)

    vote = Vote.find(vote_id)

    voter = vote.voteable

    bill = vote.bill

    if vote.in_favor
    	position_on_bill = "In Favor Of"
    else
    	position_on_bill = "Against"
    end


    require 'mandrill'
	mandrill = Mandrill::API.new "#{ENV['MANDRILL_APIKEY']}"
	message = {  
	 :subject=> "New Vote on Whip from #{voter.name}",  
	 :from_name=> "#{voter.name}",  
	 :text=>"A new vote from your constituency has come in

	 Voter Name: #{voter.name}
	 Contact Email: #{voter.email}
	 Voter Address: #{voter.street_addr} #{voter.city}, #{voter.post_code}

	 Bill Name: #{bill.official_name}
	 Vote: #{position_on_bill}
	 Comment From Voter: #{vote.comment}

	 I will be using Whip for all my political insights!",  
	 :to=>[  
	   {  
	     :email=> "test@mps.com",  
	     :name=> "#{voter.constituency.mp.name}"  
	   }  
	 ],  
	 :html=>"<html>
	 <h2>A new vote from your constituency has come in</h2><br>
	 <p>Voter Name: #{voter.name}</p>
	 <p>Contact Email: #{voter.email}</p><br>

	 <p>Bill Name: #{bill.official_name}</p>
	 <p>Vote: #{position_on_bill}</p>
	 <p>Comment From Voter: #{vote.comment}</p><br>

	 <p>I will be using Whip for all my political insights!</p>
	 </html>",  
	 :from_email=>"#{voter.email}"  
	}  
	sending = mandrill.messages.send message


  rescue Resque::TermException
  	Resque.enqueue(self, key)
  end

end