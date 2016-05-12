require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'simplecov'
SimpleCov.start

class ActiveSupport::TestCase
  fixtures :all
end
