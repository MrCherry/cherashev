source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sassc-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'

# JavaScript runtime
gem 'execjs', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster.
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'

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
gem 'activemodel-serializers-xml', git: 'https://github.com/rails/activemodel-serializers-xml'
gem 'draper', '~> 3.0.0.pre1'

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

# RestClient
gem 'rest-client'

# Rails routes inside JS
gem 'js-routes'

# Auth
gem 'devise'
gem 'cancancan'

# Slug generation
gem 'friendly_id'

# Fake data generation
gem 'faker'

group :development do
  # Deployment
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false

  # Ruby static code analyzer
  gem 'rubocop', require: false

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development, :test do
  # Better console
  gem 'pry-rails'

  # Spring speeds up development by keeping your application running in the background
  gem 'spring'
end

group :test do
  gem 'webmock'
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'headless'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'site_prism'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'shoulda-matchers'
end
