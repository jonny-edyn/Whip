class AddMp

  @queue = :mp_queue

  def self.perform(constituency_id)

  	constituency = Constituency.find(constituency_id)
  	@name = constituency.name
	encoded_url_3 = URI.encode("http://data.parliament.uk/membersdataplatform/services/mnis/members/query/House=Commons|Membership=all|Constituency*#{@name}/")
	@doc_3 = Nokogiri::HTML(open(encoded_url_3))
	@mp = @doc_3.xpath("//member").first
	@mp_final = []
	@mp_final << {"name" => @mp.xpath('displayas').text}
	@mp_name = @mp_final.first['name']
	@name_new = @mp_name.split(' ')
	@name_all_but_last_element = @name_new[0...-1]
	@name_last_element = @name_new[-1]
	@second_half_name = @name_all_but_last_element.join(" ")
    @voting_name = "#{@name_last_element}, #{@second_half_name}"
	mp = Mp.new
		mp.name = @mp_name
		mp.constituency_id = constituency_id
		mp.voting_name = @voting_name
	mp.save

  end

    

end