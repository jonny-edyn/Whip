class AddMp

  @queue = :mp_queue

  def self.perform(constituency_id)

  	constituency = Constituency.find(constituency_id)
  	@name = constituency.name
	encoded_url_3 = URI.encode("http://data.parliament.uk/membersdataplatform/services/mnis/members/query/House=Commons|Constituency=#{@name}/")
	@doc_3 = Nokogiri::HTML(open(encoded_url_3))
	@mp = @doc_3.xpath("//member").first
	@member_id = @mp.attr('member_id')
	@mp_final = []
	if @mp.xpath('displayas')
		@mp_final << {"name" => @mp.xpath('displayas').text}
		@mp_name = @mp_final.first['name']
		@name_new = @mp_name.split(' ')
		@name_all_but_last_element = @name_new[0...-1]
		@name_last_element = @name_new[-1]
		@second_half_name = @name_all_but_last_element.join(" ")
	    @voting_name = "#{@name_last_element}, #{@second_half_name}"
	end

    encoded_url_4 = URI.encode("http://data.parliament.uk/membersdataplatform/services/mnis/members/query/House=Commons|Membership=all|id=#{@member_id}/Addresses/")
	@doc_4 = Nokogiri::HTML(open(encoded_url_4))
	@twitter = @doc_4.xpath('//type[text()="Twitter"]').first
	if @twitter && @twitter.next.next.next.next
		@twitter_link = @twitter.next.next.next.next.text
	end
	@facebook = @doc_4.xpath('//type[text()="Facebook"]').first
	if @facebook && @facebook.next.next.next.next
		@facebook_link = @facebook.next.next.next.next.text
	end
	if @doc_4.xpath('//email') && @doc_4.xpath('//email').first
		@email = @doc_4.xpath('//email').first.text
	end
	if @doc_4.xpath('//phone') && @doc_4.xpath('//phone').first
		@phone = @doc_4.xpath('//phone').first.text
	end

	mp = Mp.new
		mp.name = @mp_name
		mp.constituency_id = constituency_id
		mp.voting_name = @voting_name
		mp.web_id = @member_id
		mp.fb_link = @facebook_link
		mp.tw_link = @twitter_link
		mp.email = @email
		mp.phone = @phone
		mp.picture_url = "http://data.parliament.uk/membersdataplatform/services/images/MemberPhoto/#{@member_id}/"
	mp.save

  end

    

end