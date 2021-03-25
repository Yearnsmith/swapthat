# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all
Listing.destroy_all
Role.destroy_all

User.create!(
  username: "admin",
  email: Faker::Internet.unique.safe_email,
  password: "ThatThis~App~Secret_Codeword+Go!"
  )

25.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.safe_email,
    username:Faker::Internet.unique.username,
    password:Faker::Internet.password,
    )
end

10.times do
  Listing.create!(
    seller_id: rand(1..26),
    title: Faker::Appliance.brand + " " + Faker::Appliance.equipment,
    description: Faker::Hipster.word + " " + Faker::Commerce.product_name
    )
end

10.times do Listing.create!(
  seller_id: rand(1..26),
  title: Faker::Commerce.product_name,
  description: Faker::Company.buzzword + " " + Faker::Hipster.sentence(word_count: 3),
  suggestion: Faker::Hipster.word + " " + Faker::Commerce.product_name
    )
end
