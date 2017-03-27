# frozen_string_literal: true

require "simplecov"
SimpleCov.start
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/pride"

ActiveSupport::Deprecation.silenced = true

class ActiveSupport::TestCase
  fixtures :all
end
