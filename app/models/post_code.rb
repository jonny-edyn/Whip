class PostCode < ActiveRecord::Base
	has_many :users
	belongs_to :constituency
end
