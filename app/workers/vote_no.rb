class VoteNo

  @queue = :voting_queue

  def self.perform(name, bill_id)

  	new_name = name.gsub('rh', '').gsub(/\s+/, ' ')
  	mp = Mp.find_by(voting_name: new_name)

  	if mp
  		unless mp.votes.where(bill_id: bill_id).any?
			@vote = mp.votes.build
				@vote.bill_id = bill_id
				@vote.in_favor = false
			@vote.save
		else
			@vote = mp.votes.find_by(bill_id: bill_id)
				@vote.in_favor = false
			@vote.save
		end
  	end


  end

    

end