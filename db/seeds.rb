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