ENV['RAILS_ENV'] ||= 'test'

# Coverage
require 'simplecov'
RSpec.configure do |config|
  if config.instance_variable_get(:@files_or_directories_to_run) == ['spec']
    SimpleCov.start 'rails'
  end
end

# CodeClimate
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'spec_helper'

# Faker
require 'faker'

# Capybara
require 'capybara/rails'

# Selenium
Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['download.default_directory'] = DownloadHelper::PATH.to_s
  Capybara::Selenium::Driver.new(app, browser: :firefox, profile: profile)
end
Capybara.javascript_driver = :selenium

# Poltergeist driver
# require 'capybara/poltergeist'
# Capybara.default_driver    = :poltergeist
# Capybara.javascript_driver = :poltergeist

# Selenium chrome driver
# Capybara.register_driver :selenium_chrome do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
