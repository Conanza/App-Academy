# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(1..5).each do |n|
  username = "user#{n}"
  user = User.create!({ username: username })
end

(1..5).each do |n|
  contact = "contact#{n}"
  email = "contact#{n}@email.com"
  Contact.create!({ email: email, name: contact, user_id: 1 })
end


(6..10).each do |n|
  contact = "contact#{n}"
  email = "contact#{n}@email.com"
  Contact.create!({email: email, name: contact, user_id: 2})
end

ContactShare.create!({contact_id: 1, user_id: 1})
ContactShare.create!({contact_id: 2, user_id: 2})
