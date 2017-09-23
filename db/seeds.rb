# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

 n = 1
 while n <= 10
  email = Faker::Internet.email
  password = "password"
  User.create!(email: email,
               name:  email,
               password: password,
               password_confirmation: password,
               uid: n
                              )
 n = n + 1
 end

 n = 1
 while n <= 10
  Facebook.create(
    title: "あああ",
    content: "hoge",
    user_id: n,
    image: open("#{Rails.root}/db/fixtures/image01.jpg")
  )
  n = n + 1
 end
