# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  )
25.times do
  User.create(
    first_name: Faker::Name.first,
    last_name: Faker::Name.last,
    user_name:Faker::Internet.unique.username,
    password:Faker::Internet.password,
    )

10.times do
  Listing.create(
    title: Faker::Appliance.brand Faker::Appliance.equipment,
    description: Faker::Hipster.word Faker::Commerce.product_name
    )

10.times do Listing.create(
  title: Faker::House.room Faker::House.furniture,
  description: Faker::Company.buzzword Faker::Commerce.product_name,
  suggestion: Faker::Commerce.material Faker::Commerce.product_name
    )
  )
