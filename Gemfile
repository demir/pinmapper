# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version')

gem 'activerecord-session_store'
gem 'acts-as-taggable-on', '~> 8.1'
gem 'acts_as_votable', '~> 0.13.2'
gem 'aws-sdk-s3', '~> 1', require: false
gem 'bootsnap', '~> 1.9', require: false
gem 'counter_culture', '~> 2.0'
gem 'devise', '~> 4.8.0'
gem 'down', '~> 5.0'
gem 'draper', '~> 4.0.2'
gem 'friendly_id', '~> 5.4.0'
gem 'geocoder', '~> 1.7.0'
gem 'hotwire-rails', '~> 0.1.3'
gem 'image_processing', '~> 1.0'
gem 'inline_svg', '~> 1.7'
gem 'jbuilder', '~> 2.11'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection', '~> 1.0'
gem 'pagy', '~> 5.4'
gem 'pg', '~> 1.2'
gem 'pg_search', '~> 2.3.5'
gem 'puma', '~> 5.5.2'
gem 'pundit', '~> 2.1'
gem 'rails', '~> 6.1.4'
gem 'redis', '~> 4.5.1'
gem 'sass-rails', '~> 6.0'
gem 'sidekiq'
gem 'simple_form', '~> 5.1'
gem 'translate_enum', '~> 0.1.3'
gem 'turbo-rails', '~> 0.8'
gem 'view_component', '~> 2.44', require: 'view_component/engine'
gem 'webpacker', '~> 5.4.3'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.19'
  gem 'pry', '~> 0.14'
  gem 'rspec-rails', '~> 5.0'
  gem 'rubocop', '~> 1.23', require: false
  gem 'rubocop-performance', '~> 1.12', require: false
  gem 'rubocop-rails', '~> 2.12', require: false
  gem 'rubocop-rspec', '~> 2.6', require: false
end

group :development do
  gem 'better_errors', '~> 2.9'
  gem 'binding_of_caller', '~> 1.0'
  gem 'brakeman', '~> 5.1'
  gem 'listen', '~> 3.7'
  gem 'rack-mini-profiler', '~> 2.3'
  gem 'spring', '~> 3.0'
  gem 'web-console', '~> 4.2'
end

group :test do
  gem 'capybara', '~> 3.36.0'
  gem 'selenium-webdriver', '~> 4.0.3'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'webdrivers', '~> 5.0'
end

gem 'tzinfo-data', '~> 1.2021', platforms: %i[mingw mswin x64_mingw jruby]
