source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.6'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'execjs', platforms: :ruby
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

# Twitter Bootstrap
gem 'bootstrap-sass'

# Generate layouts
gem 'rails_layout', group: :development

# Slim
gem 'slim-rails'
gem 'html2slim', group: :development

gem 'bootstrap-wysihtml5-rails'
gem 'simple_form'

# Decorators
gem 'draper'

# Use Puma as the app server
gem 'puma'

# i18n
gem 'rails-i18n'

# NProgress
gem 'nprogress-rails'

# Pagination
gem 'kaminari'
gem 'kaminari-i18n'

# Truncate text
gem 'truncate_html'

# Redis cache store
gem 'redis-rails'
gem 'redis-rack-cache'

# RestClient
gem 'rest-client'

# Rails routes inside JS
gem 'js-routes'

# Auth
gem 'devise'
gem 'cancancan'

# States
# gem 'state_machine'

# Slug generation
# gem 'friendly_id'

# Fake data generation
gem 'faker'

group :development do
  # Deployment
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false

  # Ruby static code analyzer
  gem 'rubocop', require: false

  # Call 'byebug' anywhere in the code to stop execution and
  # get a debugger console
  # gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  # gem 'web-console', '~> 2.0'
end

group :development, :test do
  # Mutes assets pipeline log messages
  gem 'quiet_assets'

  # Better console
  gem 'pry-rails'

  # Spring speeds up development by keeping your application running
  # in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'site_prism'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'shoulda-matchers'
  gem 'codeclimate-test-reporter', require: false
end
