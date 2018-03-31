# frozen_string_literal: true

require "simplecov"
SimpleCov.start
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
require "rails/test_help"
require "minitest/pride"

ActiveSupport::Deprecation.silenced = true

class ActiveSupport::TestCase
  fixtures :all

  set_fixture_class schedules_categories: Schedules::Category,
                    schedules_category_courses: Schedules::CategoryCourse,
                    schedules_category_offerings: Schedules::CategoryOffering
end
