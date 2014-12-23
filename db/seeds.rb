
password = 'passwd1234'

puts "Creating fake users..."

for i in 1..30
  User.create(name: Faker::Name.name, password: password, password_confirmation: password, email: Faker::Internet.email)
end

puts "Created!"
