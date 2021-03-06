# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Use unicorn as the app server
gem 'unicorn', '~> 6.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11'
# Fast JSON Parser
gem 'oj', '~> 3.11.5'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.7.4', require: false

# omniauth to Amazon's cognito
gem 'omniauth-cognito-idp'
gem 'omniauth-rails_csrf_protection'

# for verify token with cognito
gem 'aws-sdk-cognitoidentityprovider'

# use redis-store for session
gem 'redis-actionpack'

# Amazon's DynamoDB
gem 'aws-sdk-dynamodb', '~> 1'

# Slack
gem 'slack-ruby-client'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'dotenv-rails'

  gem 'rubocop', '~> 1', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'

  # 従来の rails s で unicorn を呼び出せるようにする
  gem 'unicorn-rails'
  # ruby error 時の画面でデバッグを可能にする
  gem 'better_errors'
  gem 'binding_of_caller'

  # console 表示
  gem 'pry-byebug'       # debugger
  gem 'pry-rails'        # rails console で pry を使う

  # rails server で /assets を proxy するのに利用
  gem 'rack-proxy'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)
