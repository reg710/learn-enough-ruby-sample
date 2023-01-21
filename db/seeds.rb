# Create a main sample user

User.create!(
  name: "Example User",
  email: "example@tutorial.org",
  password: "password",
  password_confirmation: "password",
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
  )
end
