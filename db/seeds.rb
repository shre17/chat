# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



password = '123456'
1.upto(5) do |i|
  User.create(
    email: "user#{i}@gmail.com",
    password: "123456",
    password_confirmation: "123456"
  )
end