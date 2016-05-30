# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create! email: 'joe.nyland@example.com', password: 'Password123', name: 'Joe Nyland'
User.create! email: 'john.ireland@example.com', password: 'Password123', name: 'John Ireland'
