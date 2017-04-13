# frozen_string_literal: true

# == Schema Information
#
# Table name: schedules
#
#  id          :integer          not null, primary key
#  offering_id :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  semester_id :integer
#

require "test_helper"

class ScheduleTest < ActiveSupport::TestCase
end
