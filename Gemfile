source 'https://rubygems.org'

gem 'rake'
gem 'rack'

group :default do
  gem 'json'
  gem 'activerecord'
  gem 'sqlite3'
end

group :client do
  gem 'rest-client'
end

group :server do
  gem 'thin'
  gem 'sinatra'
  gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
end

group :test do
  gem 'rack-test'
  gem 'test-unit'
end
