# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ title: 'Star Wars' }, { title: 'Lord of the Rings' }])
#   Character.create(title: 'Luke', movie: movies.first)
48.times do
  titles = []
  title = Faker::Name.name_with_middle
  while titles.include? title do
    title = Faker::Name.name_with_middle
  end
  movie = Movie.new
  movie.title = title
  movie.release_date = Faker::Date.between(15.years.ago, Date.today)
  movie.duration = Faker::Number.number(3)
  movie.loan_price = Faker::Number.decimal(2, 2)
  2.times do
    movie.category_list.add("Category 1 to #{title}", "Category 2 to #{title}")
    movie.director_list.add("Director 1 to #{title}", "Director 2 to #{title}")
    movie.writer_list.add("Writer 1 to #{title}", "Writer 2 to #{title}")
    movie.actor_list.add("Actor 1 to #{title}", "Actor 2 to #{title}")
  end
  movie.save
end