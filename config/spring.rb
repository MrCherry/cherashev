if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'

  %w(
    .ruby-version
    .ruby-gemset
    .rbenv-vars
    tmp/restart.txt
    tmp/caching-dev.txt
  ).each { |path| Spring.watch(path) }
end
