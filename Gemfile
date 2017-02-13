# frozen_string_literal: true
source "https://rubygems.org"

ruby "2.3.3"
gem "rails"

gem "coffee-rails"
gem "jquery-rails"
gem "sass-rails"
gem "turbolinks"
gem "uglifier"

gem "puma"

gem "devise"
gem "pg"
gem "rails_12factor", group: :production

gem "cancancan"
gem "carrierwave"
gem "cocoon"
gem "haml"
gem "kaminari"
gem "numbers_and_words"
gem "pry-rails"

group :test do
  gem "codeclimate-test-reporter", require: nil
  gem "simplecov", require: false
end

group :development do
  gem "listen"
  gem "seed_dump"
  gem "spring"
  gem "spring-watcher-listen"
  gem "web-console"
end

group :development, :test do
  gem "haml-lint"
  gem "rubocop"
end
