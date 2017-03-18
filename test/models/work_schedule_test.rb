# frozen_string_literal: true
# == Schema Information
#
# Table name: work_schedules
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  work_days_time_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#  semester_id       :integer
#

require "test_helper"

class WorkScheduleTest < ActiveSupport::TestCase
  test "pretty_day_time" do
    assert work_schedules(:one).pretty_day_time == "M830AM"
  end

  test "prettier_day_time" do
    assert work_schedules(:one).prettier_day_time == "M8:30AM"
  end
end
