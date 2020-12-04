# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  User.create!(
    last_name: Faker::Name.last_name,
    first_name: Faker::Name.first_name,
    email: Faker::Internet.safe_email,
    password: 'password',
    password_confirmation: 'password'
  )
end

20.times do |n|
  Board.create!(
    title: Faker::Game.title,
    body: Faker::Movie.quote,
    user: User.find(rand(1..10))
  )
end

# ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'users'")
