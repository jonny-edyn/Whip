class Relationship < ActiveRecord::Base
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User" 

	validates :follower_id, presence: true
	validates :followed_id, presence: true

	after_create :increment_counter_cache
	after_destroy :decrement_counter_cache

	private

	def increment_counter_cache
		User.increment_counter("followers_count", follower_id)
		User.increment_counter("followed_users_count", followed_id)
	end

	def decrement_counter_cache
		User.decrement_counter("followers_count", followed_id)
		User.decrement_counter("followed_users_count", follower_id)
	end

end
