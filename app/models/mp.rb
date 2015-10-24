class Mp < ActiveRecord::Base
	belongs_to :constituency
	has_many :users, through: :constituency
	has_many :votes, as: :voteable

	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    product = find_by_id(row["id"]) || new
	    product.attributes = row.to_hash.slice('fb_link', 'tw_link', 'email', 'name', 'phone', 'picture_url', 'web_id', 'voting_name')
	    product.save!
	  end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when ".csv" then Roo::Csv.new(file.path)
	  when ".xls" then Roo::Excel.new(file.path)
	  when ".xlsx" then Roo::Excelx.new(file.path)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end

	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |mp|
	      csv << mp.attributes.values_at(*column_names)
	    end
	  end
	end

	def self.find_mp_for(user)
		if user
			Mp.joins(:users).includes(:constituency).where('users.id' => user.id).first
		else
			nil
		end
	end

	def voted_on?(bill)
		votes.where(bill_id: bill.id).first
	end


end
