class MpsSet

  @queue = :mp_queue

  def self.perform()

  	Mp.delete_all

	constituencies = Constituency.all
	constituencies.each_with_index do |constituency, index|
		if index == 0
			@setting = Setting.find_by(name: 'updating_mp_list')
				@setting.yes = true
			@setting.save
		elsif index == constituencies.size - 1
			@setting = Setting.find_by(name: 'updating_mp_list')
				@setting.yes = false
			@setting.save
		end
				
		Resque.enqueue(AddMp, constituency.id)
  	end
  end

end