# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user1 = User.create(username: "John Doe")
user2 = User.create(username: "Jane Doe")
user3 = User.create(username: "Bob Doe")

contact1 = Contact.create(name: "John Doe", email: "john@somthing", user_id: user1.id)
contact2 = Contact.create(name: "Jane", email: "jane@somthing", user_id: user2.id)
contact3 = Contact.create(name: "Bob", email: "bob@somthing", user_id: user3.id)


cs1 = ContactShare.create(user_id: user1.id, contact_id: contact1.id)
cs2 = ContactShare.create(user_id: user2.id, contact_id: contact1.id)
