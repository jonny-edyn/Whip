class ConstituenciesSet

  @queue = :constituency_queue

  def self.perform()

  	require 'open-uri'
	encoded_url_2 = URI.encode('http://data.parliament.uk/membersdataplatform/services/mnis/ReferenceData/Constituencies/')
	@doc_2 = Nokogiri::HTML(open(encoded_url_2))
	@constituencies = []
	@doc_2.xpath("//constituency").each do |constituency|
		if constituency.xpath('enddate').text == ""
	 		@constituencies << { "name" => constituency.xpath('name').text, "constituency_web_id" => constituency.xpath('constituency_id').text}
	 	end
	end
	if @constituencies.any?
		@constituencies.each_with_index do |constituency_add, index|
			if Constituency.where(web_id: constituency_add['constituency_web_id']).any?
				Resque.enqueue(UpdateConstituency, constituency_add['name'], constituency_add['constituency_web_id'])
			else
				Resque.enqueue(AddConstituency, constituency_add['name'], constituency_add['constituency_web_id'])
			end
		end
	end

  end
end