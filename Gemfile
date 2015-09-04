source 'https://rubygems.org'
ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'bcrypt'
gem 'faker'
gem 'bower-rails'
gem 'will_paginate'

gem 'bootstrap-will_paginate'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '~> 5.0'
gem 'compass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'

gem 'angularjs-rails'
gem 'angular-rails-templates'
gem 'angular_rails_csrf'

gem 'active_model_serializers', '~> 0.9.3'
gem 'rails-html-sanitizer'
gem 'sprockets', '2.12.4'
gem 'responders', '~>2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'stripe', git: 'https://github.com/stripe/stripe-ruby'
gem 'carrierwave', github:'carrierwaveuploader/carrierwave'
gem 'mini_magick'
gem 'fog'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'guard-rspec'
end

group :test do
	gem 'minitest-reporters'
	gem 'mini_backtrace'
	gem 'guard-minitest'
end

group :production do
	gem 'pg'
	gem 'rails_12factor'
	gem 'unicorn'
end
