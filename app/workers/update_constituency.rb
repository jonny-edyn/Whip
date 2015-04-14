class UpdateConstituency

  @queue = :constituency_queue

  def self.perform(name_new, web_id)

  	c = Constituency.find_by(web_id: web_id)
		c.name = name_new
	c.save

  end

    

end