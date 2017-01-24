# frozen_string_literal: true
require "test_helper"

class WorkScheduleTest < ActiveSupport::TestCase
  test "pretty_day_time" do
    assert work_schedules(:one).pretty_day_time == "M830AM"
  end

  test "prettier_day_time" do
    assert work_schedules(:one).prettier_day_time == "M8:30AM"
  end
end
