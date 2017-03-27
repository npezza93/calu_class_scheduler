# frozen_string_literal: true

# == Schema Information
#
# Table name: schedule_approvals
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  approved    :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#  semester_id :integer
#

require "test_helper"

class ScheduleApprovalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
