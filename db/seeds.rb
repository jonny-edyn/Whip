# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  admin_list = [
    ["me@admin.com", 'adminpass', 'adminpass', 'Jonny'],
  ]

  admin_list.each do |email, password, password_confirmation, name|
    u = User.create( email: email, password: password, password_confirmation: password_confirmation)
    u.name = name
    u.admin = true
    valid = u.valid?
    u.save
  end

    user_list = [
    ["1@user.com", 'userpass', 'userpass', 'Steve'],
    ["2@user.com", 'userpass', 'userpass', 'Sara'],
    ["3@user.com", 'userpass', 'userpass', 'Jerry'],
    ["4@user.com", 'userpass', 'userpass', 'Tommy'],
    ["5@user.com", 'userpass', 'userpass', 'Terry'],
    ["6@user.com", 'userpass', 'userpass', 'Titan'],
    ["7@user.com", 'userpass', 'userpass', 'Mike'],
    ["8@user.com", 'userpass', 'userpass', 'Coke'],
    ["9@user.com", 'userpass', 'userpass', 'Luis'],
    ["10@user.com", 'userpass', 'userpass', 'Kathryn'],
  ]

  user_list.each do |email, password, password_confirmation, name|
    u = User.create( email: email, password: password, password_confirmation: password_confirmation)
    u.name = name
    valid = u.valid?
    u.save
  end