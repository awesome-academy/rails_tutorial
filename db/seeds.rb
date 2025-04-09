
User.create!(
  name: "example",
  email: "example@railstutorial.org",
  password: "football",
  password_confirmation: "football", admin: true
)


99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end

# Following relationships
puts "create relatiopnship"
users = User.all
user = users.first
following = users[2..20]
followers = users[3..15]
following.each{|followed|user.follow(followed)}
followers.each{|follower|follower.follow(user)}
