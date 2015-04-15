class MpsSet

  @queue = :mp_queue

  def self.perform()

  	Mp.delete_all

	constituencies = Constituency.all
	constituencies.each do |constituency|
		Resque.enqueue(AddMp, constituency.id)
  	end
  end

end