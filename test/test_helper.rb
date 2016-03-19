ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'simplecov'
SimpleCov.start
require 'active_support/testing/assertions'

module ActiveSupport
  class TestCase
    fixtures :all

    include ActiveSupport::Testing::Assertions
  end
end
