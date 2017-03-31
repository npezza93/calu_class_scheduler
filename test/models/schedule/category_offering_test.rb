# frozen_string_literal: true

# == Schema Information
#
# Table name: schedule_category_offerings
#
#  id          :integer          not null, primary key
#  offering_id :integer
#  category_id :integer
#  hidden      :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require "test_helper"

class Schedule::CategoryOfferingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
