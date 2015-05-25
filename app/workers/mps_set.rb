class MpsSet

  @queue = :mp_queue

  def self.perform()

  	Mp.delete_all

	constituencies = Constituency.all
	constituencies.each_with_index do |constituency, index|
		Resque.enqueue(AddMp, constituency.id)
  	end
  end

end