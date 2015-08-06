# real user/login that we want
User.create!(name: 'Kevin Suh',
						 email: 'kevinsuh34@gmail.com',
						 password: 'kevinsuh',
						 password_confirmation: 'kevinsuh',
						 is_admin: true,
						 is_activated: true,
 						 activated_at: Time.zone.now )

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

users = User.order(:created_at).take(6)
55.times do
	content = Faker::Lorem.sentence(5)
	users.each do |user|
		user.microposts.create!(content: content)
	end
end