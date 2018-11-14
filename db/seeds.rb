# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ title: 'Star Wars' }, { title: 'Lord of the Rings' }])
#   Character.create(title: 'Luke', movie: movies.first)

# require 'csv'
# 
# data = File.read('/home/yulier/Music/15102018/films.csv')
# CSV.parse(data, headers: true).each do |row|
#   m = Movie.new
#   m.title = row['title'].strip
#   m.release_date = Date.strptime(row['release_date'].strip, '%d/%m/%Y')
#   m.country = row['country'].strip
#   m.classification = row['classification']
#   m.duration = row['duration'].strip.to_i
#   m.category_list = row['categories'].strip.downcase
#   m.director_list = row['directors'].strip
#   m.writer_list = row['writers'].strip
#   m.actor_list = row['actors'].strip
#   m.imdb_code = row['imdb_code'].strip
#   m.youtube_trailer_code = row['youtube_trailer_code'].strip
#   puts File.exists?("/home/yulier/Music/15102018/seeds/#{row['imdb_code'].strip}.jpg")
#   m.cover.attach(io: File.open("/home/yulier/Music/15102018/seeds/#{row['imdb_code'].strip}.jpg"), filename: "#{row['imdb_code'].strip}.jpg", content_type: 'image/jpg')
#   m.save
# end

# u = User.new
# u.first_name = 'Peter'
# u.last_name = 'Jackson'
# u.email = 'peter@gmail.com'
# u.password = 'rocketlauncher'
# u.save
