ENV['RAILS_ENV'] ||= 'test'

# Coverage
require 'simplecov'
RSpec.configure do |config|
  if config.instance_variable_get(:@files_or_directories_to_run) == ['spec']
    SimpleCov.start 'rails' do
      add_group 'Decorators', 'app/decorators'
      add_group 'Services', 'app/services'
    end
  end
end

# WebMock
require 'webmock/rspec'
WebMock.enable!(allow_localhost: true)
WebMock.disable_net_connect!(allow_localhost: true)
WebMock.stub_request(:fonts, /maps\.googleapis\.com.*'/).with(body: '')

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'spec_helper'

# Faker
require 'faker'

# Capybara
require 'capybara/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.infer_base_class_for_anonymous_controllers = false
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
