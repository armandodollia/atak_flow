commentable_types = %w(Question Answer)
votable_types = %w(Question Answer Comment)

10.times do
  User.create!(username: Faker::Internet.user_name, email: Faker::Internet.email, password: "potato")
  Question.create!(title: Faker::Book.title, body: Faker::ChuckNorris.fact, user_id: rand(1..10))
  Answer.create!(body: Faker::ChuckNorris.fact, user_id: rand(1..10), question_id: rand(1..10))
  Comment.create!(body: Faker::Hipster.paragraph, user_id: rand(1..10), commentable_id: rand(1..10),
                  commentable_type: commentable_types.sample)
  Vote.create!(value: 1, user_id: rand(1..10), votable_id: rand(1..10), votable_type: votable_types.sample)
end
