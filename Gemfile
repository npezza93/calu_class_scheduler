# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.5.1"

gem "devise"
gem "pg"
gem "puma"
gem "rails"

gem "babel-transpiler"
gem "coffee-rails"
gem "jquery-rails"
gem "material_icons"
gem "sass-rails"
gem "spring"
gem "sprockets", "~> 4.0.0beta4"
gem "turbolinks"
gem "uglifier"

gem "pry-rails"

gem "cancancan"
gem "carrierwave"
gem "cocoon"
gem "haml"
gem "kaminari"
gem "numbers_and_words"

group :development do
  gem "listen"
  gem "rack-mini-profiler"
  gem "seed_dump"
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
