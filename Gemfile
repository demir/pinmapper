# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version')

gem 'bootsnap', require: false
gem 'devise'
gem 'hotwire-rails'
gem 'jbuilder'
gem 'pg'
gem 'puma'
gem 'rails'
gem 'redis'
gem 'sass-rails'
gem 'simple_form'
gem 'webpacker'
gem 'draper'
gem 'view_component', require: 'view_component/engine'
gem 'translate_enum'
gem 'inline_svg'
gem 'geocoder'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'shoulda-matchers'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen'
  gem 'rack-mini-profiler'
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
