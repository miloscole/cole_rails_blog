3.times { User.create(Faker::Internet.user("username", "email", "password")) }

5.times do |i|
  User.create(
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: "password" + i.to_s,
  )
end

10.times do
  Article.create(
    title: Faker::Book.title,
    text: Faker::Lorem.paragraph(sentence_count: 3),
    user_id: rand(1..8),
  )
end

5.times do
  Category.create(name: Faker::Sport.sport)
end
