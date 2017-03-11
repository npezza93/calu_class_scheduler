# frozen_string_literal: true
source "https://rubygems.org"

ruby "2.4.0"

gem "devise"
gem "pg"
gem "puma"
gem "rails", "~> 5.1.0beta1"

gem "coffee-rails"
gem "jquery-rails"
gem "material_icons"
gem "sass-rails"
gem "turbolinks"
gem "uglifier"

gem "pry-rails"

gem "cancancan"
gem "carrierwave"
gem "cocoon"
gem "haml", "~> 5.0.0.beta.2"
gem "kaminari"
gem "numbers_and_words"

group :development do
  gem "listen"
  gem "seed_dump"
  gem "spring"
  gem "web-console"
end

group :test do
  gem "codeclimate-test-reporter", require: nil
  gem "simplecov", require: false
end

group :development, :test do
  gem "haml_lint"
  gem "rubocop"
end

group :production do
  gem "rails_12factor"
end
