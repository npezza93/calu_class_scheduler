# frozen_string_literal: true

# == Schema Information
#
# Table name: schedules_categories
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  curriculum_category_id :integer
#  semester_id            :integer
#  completed              :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require "test_helper"

module Schedules
  class CategoryTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
