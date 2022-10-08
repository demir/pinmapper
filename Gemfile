# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version')

gem 'activerecord-session_store'
gem 'acts_as_list', '~> 1.0'
gem 'acts-as-taggable-on', '~> 9.0'
gem 'acts_as_votable', '~> 0.13.2'
gem 'aws-sdk-s3', '~> 1', require: false
gem 'bootsnap', '~> 1.9', require: false
gem 'cloudinary'
gem 'counter_culture', '~> 3.2'
gem 'devise'
gem 'draper', '~> 4.0.2'
gem 'friendly_id', '~> 5.4.0'
gem 'geocoder', '~> 1.8'
gem 'image_processing', '~> 1.0'
gem 'inline_svg', '~> 1.8'
gem 'jbuilder', '~> 2.11'
gem 'meta-tags'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection', '~> 1.0'
gem 'pagy', '~> 5.4'
gem 'pg', '~> 1.2'
gem 'pg_search', '~> 2.3'
gem 'puma', '~> 5.6'
gem 'pundit', '~> 2.1'
gem 'rails', '~> 7.0.4'
gem 'redis', '~> 5.0'
gem "ruby-oembed"
gem 'sass-rails', '~> 6.0'
gem 'sidekiq'
gem 'simple_form', '~> 5.1'
gem 'stimulus-rails'
gem 'translate_enum', '~> 0.1.3'
gem 'turbo-rails'
gem 'view_component'
gem 'webpacker', '5.4.3'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2'
  gem 'pry', '~> 0.14'
  gem 'rspec-rails', '~> 6.0.0.rc1'
  gem 'rubocop', '~> 1', require: false
  gem 'rubocop-performance', '~> 1', require: false
  gem 'rubocop-rails', '~> 2', require: false
  gem 'rubocop-rspec', '~> 2', require: false
end

group :development do
  gem 'better_errors', '~> 2.9'
  gem 'binding_of_caller', '~> 1.0'
  gem 'brakeman', '~> 5.1'
  gem 'listen', '~> 3.7'
  gem 'rack-mini-profiler', '~> 3'
  gem 'spring', '~> 4'
  gem 'web-console', '~> 4.2'
end

group :test do
  gem 'capybara', '~> 3.37'
  gem 'selenium-webdriver', '~> 4.0.3'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'webdrivers', '~> 5.0'
end

gem 'tzinfo-data', '~> 1.2021', platforms: %i[mingw mswin x64_mingw jruby]
