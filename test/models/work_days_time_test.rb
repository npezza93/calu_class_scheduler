# frozen_string_literal: true

# == Schema Information
#
# Table name: work_days_times
#
#  id         :integer          not null, primary key
#  days       :string(255)
#  start_time :time
#  end_time   :time
#  created_at :datetime
#  updated_at :datetime
#

require "test_helper"

class WorkDaysTimeTest < ActiveSupport::TestCase
  test "short time" do
    monday = WorkDaysTime.where(days: "M").order(:start_time).first
    assert monday.short_time,
           monday.days + monday.start_time.strftime("%l%M%p").strip
  end
end
