desc "This is how we update DB with all of our MPs"
task :add_mps_to_db => :environment do
	Resque.enqueue(MpsSet)
end