source 'https://rubygems.org'

gem 'sinatra'
gem 'tilt', '~> 1.4.1'
gem 'tilt-jbuilder', require: 'sinatra/jbuilder'
gem 'capistrano'

gem 'httparty'
gem 'ooor', github: 'akretion/ooor'

group :test do
  gem 'vcr'
  gem 'rspec', '= 2.13.0'
  gem 'webmock', '= 1.11.0'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rack-test'
  gem 'simplecov', require: false
end

group :production do
  gem 'foreman'
  gem 'unicorn'
end

group :development do
  gem 'shotgun'
  gem 'pry'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
end

gem 'endpoint_base', git: 'git@github.com:spree/endpoint_base.git', :branch => 'v5'
  # :path => '../endpoint_base'
