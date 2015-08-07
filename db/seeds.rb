# real user/login that we want
User.create!(name: 'Kevin Suh',
						 email: 'kevinsuh34@gmail.com',
						 password: 'kevinsuh',
						 password_confirmation: 'kevinsuh',
						 is_admin: true,
						 is_activated: true,
 						 activated_at: Time.zone.now )

# create 100 users
99.times do |n|
	name = Faker::Name.name
	email = "testemail-#{n+1}@mail.com"
	password = "password"

	User.create!( name: name,
								email: email,
								password: password,
								password_confirmation: password,
								is_activated: true,
 								activated_at: Time.zone.now )

end

# create microposts for first 6 users
users = User.order(:created_at).take(6)
55.times do
	content = Faker::Lorem.sentence(5)
	users.each do |user|
		user.microposts.create!(content: content)
	end
end

# create relationships for users
kevin = User.find_by(email: "kevinsuh34@gmail.com")
other_user = User.second

# have kevin follow 15 guys
15.times do |n|
	user = User.find_by(id: n)
	another_user = User.find_by(id: (n+10))
	if user
		kevin.follow(user)
	end
	if another_user
		other_user.follow(another_user)
	end
end

