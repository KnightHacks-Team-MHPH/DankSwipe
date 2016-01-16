# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user_1 = User.create!(email: "user1@example.com", password: "password", password_confirmation: "password")
user_2 = User.create!(email: "user2@example.com", password: "password", password_confirmation: "password")


user_2.memes.create!(meme_url: "http://i.imgur.com/VuzpTHC.jpg?1", owner_id: user_2.id)
user_2.memes.create!(meme_url: "http://i.imgur.com/9YuOff8.jpg", owner_id: user_2.id)
user_2.memes.create!(meme_url: "http://i.imgur.com/hUBGxJV.jpg", owner_id: user_2.id)
