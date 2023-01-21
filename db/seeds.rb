# Create a main sample user

User.create!(name: 'Example User', 
    email: "example@tutorial.org",
    password: "password",
    password_confirmation: "password"
)

# Generate a bunch of additional users
99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@tutorial.org"
    password = "password"
    User.create!(name: name, 
        email: email, 
        password: password, 
        password_confirmation: password
    )
end