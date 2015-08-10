# real user/login that we want
# User.create!(name: 'Kevin Suh',
# 						 email: 'kevinsuh34@gmail.com',
# 						 password: 'kevinsuh',
# 						 password_confirmation: 'kevinsuh',
# 						 is_admin: true,
# 						 is_activated: true,
#  						 activated_at: Time.zone.now )

# 99.times do |n|
# 	name = Faker::Name.name
# 	email = "testemail-#{n+1}@mail.com"
# 	password = "password"

# 	User.create!( name: name,
# 								email: email,
# 								password: password,
# 								password_confirmation: password,
# 								is_activated: true,
#  								activated_at: Time.zone.now )

# end

# 3.times do |n|
# 	title = Faker::Lorem.sentence
# 	if n % 6 == 0
# 		link = "http://www.realgm.com"
# 	end

# 	post = Post.create!( title: title,
# 											 link: link,
# 											 upvotes: 0)
# 	4.times do
# 		post.comments.create!(body: Faker::Lorem.sentence,
# 			upvotes: 0)
# 	end
# end