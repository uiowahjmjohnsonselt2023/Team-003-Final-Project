require 'simplecov'                            # load SimpleCov for code coverage analysis
SimpleCov.start 'rails'                 # start SimpleCov with Rails profile

require 'cucumber/rails'                      # load Cucumber with Rails integration

ActionController::Base.allow_rescue = false   # disable automatic exception handling in ActionController

ENV['RAILS_ENV'] ||= 'test'                   # set the default Rails environment to 'test'


require 'database_cleaner'                    # load DatabaseCleaner for database management
DatabaseCleaner.strategy = :transaction       # set the cleaning strategy to transaction

Before do
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end

Cucumber::Rails::Database.javascript_strategy = :truncation  # set the JavaScript strategy to truncation
