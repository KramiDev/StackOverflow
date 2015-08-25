require 'rails_helper'
require 'capybara/poltergeist'

RSpec.configure do |config|
  Capybara.javascript_driver = :poltergeist

  options = {js_errors: false}
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, options)
  end

  config.include AcceptanceHelper, type: :feature
  config.include SphinxHelpers, type: :feature

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end



  config.before(:suite) do
    # Ensure sphinx directories exist for the test environment
    ThinkingSphinx::Test.init
    # Configure and start Sphinx, and automatically
    # stop Sphinx at the end of the test suite.
    ThinkingSphinx::Test.start_with_autostop
  end
end