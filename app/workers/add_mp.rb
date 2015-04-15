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
	mp = Mp.new
		mp.name = @mp_name
		mp.constituency_id = constituency_id
	mp.save

  end

    

end