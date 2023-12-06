source "https://rubygems.org"

ruby "2.7.3"

gem "rails", "~> 7.1.1"
gem 'bcrypt', '~> 3.1.7'
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]
gem 'actionmailer'
gem 'google_sign_in'
gem 'omniauth-github', '~> 2.0.0'
gem "omniauth-rails_csrf_protection"
gem 'figaro'


group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'faker'
  gem 'simplecov', require: false
  gem 'shoulda-matchers', '~> 5.0'
  gem 'rspec-rails'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'rails-controller-testing'
  gem 'rack_session_access'
end

group :test, :development do
  gem 'cucumber-rails', require: false
end

