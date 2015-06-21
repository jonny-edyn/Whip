require 'voting_lib'
class VotesSet
	extend VotingLib

  @queue = :vote_queue


  def self.perform(bill_id, web_url)

  	encoded_url_2 = URI.encode(web_url)
	@doc_2 = Nokogiri::HTML(open(encoded_url_2))
	@doc_3 = @doc_2.xpath('//b[text()="AYES"]').first.parent
	@doc_4 = @doc_2.xpath('//b[text()="NOES"]').first.parent
	@end_element_yes = @doc_2.xpath('//b[text()="Tellers for the Ayes:"]').first.parent
	@end_element_no = @doc_2.xpath('//b[text()="Tellers for the Noes:"]').first.parent
	@yes_votes = []
	@no_votes = []
	@yes_node = true
	@no_node = true
	collect_yes(@doc_3)
	collect_no(@doc_4)


  	if @yes_votes.any?
		@yes_votes.each do |name|

			new_name = name.gsub('rh', '').gsub(/\s+/, ' ')
  			mp = Mp.find_by(voting_name: new_name)

			if mp
		  		unless mp.votes.where(bill_id: bill_id).any?
					@vote = mp.votes.build
						@vote.bill_id = bill_id
						@vote.in_favor = true
					@vote.save
				else
					@vote = mp.votes.find_by(bill_id: bill_id)
						@vote.in_favor = true
					@vote.save
				end
		  	end

		end
	end

	if @no_votes.any?
		@no_votes.each do |name|


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

  end

end