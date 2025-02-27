# Create a main sample user

User.create!(
  name: "Example User",
  email: "example@railstutorial.org",
  password: "password",
  password_confirmation: "password",
  admin: true,
  activated: true,
  # Rails helper that returns current timestamp while accounting for time zone on the server
  activated_at: Time.zone.now,
)

# Generate a bunch of additional users
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  # The ! means it will raise an exception for an invalid user rather than returning false
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now,
  )
end

# Microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Create following relationships

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
