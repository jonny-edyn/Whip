# More robust version to update new or existing counter cache columns in your Rails app.
# See: https://gist.github.com/svyatov/4225663
desc 'Update all cache counters'
task :update_cache_counters => :environment do
  User.all.each do |user|
    User.reset_counters(user.id, :votes)
    user.update_attributes(followed_users_count: user.followed_users.count)
    user.update_attributes(followers_count: user.followers.count)
  end
end