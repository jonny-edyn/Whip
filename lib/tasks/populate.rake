namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker' 

	 100.times do
	    b = Bill.new
	      b.simple_name = Faker::Name.name
	      b.official_name = Faker::Name.name
	      b.support = Faker::Lorem.paragraphs
	      b.opposition = Faker::Lorem.paragraphs
	      b.cost = Faker::Lorem.paragraphs
	      b.impact = Faker::Lorem.paragraphs
	      b.meaning = Faker::Lorem.paragraphs
    	b.save
	  end
	end
end