desc "This is how we update DB with all of our Constituencies"
task :add_constituencies_to_db do
	Resque.enqueue(ConstituenciesSet)
end