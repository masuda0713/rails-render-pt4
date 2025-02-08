source "https://rubygems.org"

ruby "3.2.2"
gem "rails", "~> 7.1.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false #Bootsnapは、Railsアプリケーションの起動時間を短縮するためのライブラリです。
gem "rack-attack", "~> 6.7" #Rack::Attackは、Rackミドルウェアとして動作する、リクエストを制限するためのライブラリです。
gem "dotenv-rails", "~> 3.1" #Dotenvは、環境変数を読み込むためのライブラリです。
gem 'rack-cors' #rack-corは、CORS（Cross-Origin Resource Sharing）を実装するためのRackミドルウェアです。

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

