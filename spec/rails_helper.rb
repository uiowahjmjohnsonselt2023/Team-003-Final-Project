require 'factory_bot_rails'
require 'faker'

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/channels/application_cable/connection.rb'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/mailers/application_mailer.rb'
end

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

# configure DatabaseCleaner
RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.include ActionView::Helpers::NumberHelper

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.strategy = strategy
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(create(:user))
  end

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
  # configure Capybara for integration testing
  Capybara.default_driver = :selenium_chrome_headless # Use headless by default for speed
  Capybara.javascript_driver = :selenium_chrome_headless
  Capybara.default_max_wait_time = 5
end

# configure Selenium to use Chrome in headless mode
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1920,1080')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end