class Bill < ActiveRecord::Base
	is_impressionable :counter_cache => true

	
	has_many :votes, dependent: :destroy

	has_many :bill_issues
	has_many :issues, through: :bill_issues

	has_many :media_links

	scope :with_matching_issue, ->(name = params[:issue_name]) {joins(:issues).merge(Issue.equal_to(name))}

	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  (2..spreadsheet.last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    product = find_by_id(row["id"]) || new
	    product.attributes = row.to_hash.slice('progress', 'meaning', 'impact', 'cost', 'trending', 'simple_name', 'official_name', 'support', 'opposition')
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
	    all.each do |bill|
	      csv << bill.attributes.values_at(*column_names)
	    end
	  end
	end

	def self.get_index_bills(user, issue_name=nil)
		bills = find_bills_matching_issue(issue_name)

		if user
			bills = bills.select { |b| !b.votes.select { |v| v.voteable_id == user.id }.any? }
		end
		return bills
	end

	def self.find_bills_matching_issue(issue_name)
		if issue_name
			return Bill.with_matching_issue(issue_name).includes(:votes, :issues).order(:impressions_count)
		else
			return Bill.includes(:votes, :issues).order(:impressions_count)
		end
	end

	def self.set_trending_bills(bills, trending_setting)
		if trending_setting
			return bills.first(3)
		else
			return bills.select { |b| b.trending }
		end
	end

	def self.set_common_bills(bills, trending_setting)
		if trending_setting
			return bills.offset(3)
		else
			return bills.select { |b| !b.trending }
		end
	end

end
