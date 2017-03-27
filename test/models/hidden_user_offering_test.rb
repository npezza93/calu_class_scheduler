# frozen_string_literal: true

# == Schema Information
#
# Table name: hidden_user_offerings
#
#  id          :integer          not null, primary key
#  offerings   :text
#  user_id     :integer
#  semester_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require "test_helper"

class HiddenUserOfferingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
