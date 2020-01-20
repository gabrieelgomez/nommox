source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# use google firebase cloud messaging
gem 'fcm'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', '< 1.4.2', require: false
gem 'msgpack', '~> 1.3.1'

gem 'bcrypt'
gem 'twitter-bootstrap-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false

  gem 'pry-rails'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# serialize records
gem 'active_model_serializers'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#postgresql
gem 'pg'

#haml
gem "haml-rails", "~> 2.0"

#simple form
gem 'simple_form'

#adminLTE
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'font-awesome-sass'

source 'https://rails-assets.org/' do
  gem 'rails-assets-adminlte'
end

#uploader
gem 'carrierwave-aws'
gem 'aws-sdk-rails'
gem 'carrierwave', '1.2.2'
gem 'mini_magick', '4.8.0'
gem 'rmagick', '2.16.0'

#permissions
gem 'pundit'

#twilio
gem 'twilio-ruby', '~> 5.25.4'

# Html to Image
gem 'imgkit'
gem 'wkhtmltoimage-binary'

# Validate phone numbers easily
gem 'phony_rails'

# Manage environments variables
gem 'dotenv-rails'

#push notifications to iOS
gem 'grocer'

#API Requests
gem 'httparty'

gem 'delayed_job_active_record'

#pagination
gem 'kaminari-bootstrap3'
