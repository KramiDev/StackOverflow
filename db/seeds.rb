# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do
  User.create(email: Faker::Internet.email, password: '12345678', password_confirmation: '12345678', confirmed_at: Time.now)
end

100.times do 
  question = Question.create(title: Faker::Lorem.sentence(1), body: Faker::Lorem.sentence(rand(2..10)), user: User.find(rand(1..100)))
  Answer.create(body: Faker::Lorem.sentence(10), user: User.find(rand(1..100)), question: question)
end    
