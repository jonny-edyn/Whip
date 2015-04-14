class AddConstituency

  @queue = :constituency_queue

  def self.perform(name_new, web_id_new)

  	c = Constituency.new
		c.web_id = web_id_new
		c.name = name_new
	c.save

  end

    

end