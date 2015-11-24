class MediaLink < ActiveRecord::Base
	belongs_to :bill

	validates :bill_id, presence: true
	validates :web_url, presence: true
end
