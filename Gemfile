source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.4'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano3-puma'
  gem 'capistrano-rbenv'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # コーディング規約
  gem 'rubocop-airbnb'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem "factory_bot_rails"
  gem 'faker'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# ログイン機能
gem 'devise'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'

# マップ
gem 'gmaps4rails'
gem 'geocoder'
gem 'gon'

# 環境変数の管理
gem 'dotenv-rails'

# レイアウト
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'kaminari', '~>1.1.1'
gem 'font-awesome-sass'

# 画像投稿
gem 'refile', require: 'refile/rails', github: 'manfe/refile'
gem 'refile-mini_magick'

# デバック
gem 'pry-rails'
gem 'pry-byebug'

# MySQLを利用するための設定
group :production do
  gem 'mysql2'
end
