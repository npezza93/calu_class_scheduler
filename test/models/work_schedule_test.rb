# frozen_string_literal: true
# == Schema Information
#
# Table name: work_schedules
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  semester_id :integer
#  day         :string
#  start_time  :time
#

require "test_helper"

class WorkScheduleTest < ActiveSupport::TestCase
end
