# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Cat.create!(birth_date: Time.now,
            color: "brown",
            name: "Breakfast",
            sex: "M",
            description: "Breakfast is delicious")
Cat.create!(birth_date: Time.now,
            color: "brown",
            name: "Lunch",
            sex: "F",
            description: "Lunch is delicious")
Cat.create!(birth_date: Time.now,
            color: "brown",
            name: "Brunch",
            sex: "F",
            description: "Brunch is delicious")
Cat.create!(birth_date: Time.now,
            color: "brown",
            name: "Dinner",
            sex: "M",
            description: "Dinner is delicious")

User.create!(username: "CJ", password: "password123")
User.create!(username: "David", password: "password123")
User.create!(username: "Andrew", password: "password123")
User.create!(username: "Eric", password: "password123")
