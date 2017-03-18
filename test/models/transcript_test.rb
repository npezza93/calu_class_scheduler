# frozen_string_literal: true
# == Schema Information
#
# Table name: transcripts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  course_id     :integer
#  created_at    :datetime
#  updated_at    :datetime
#  grade_c_minus :boolean
#  grade_c       :boolean
#

require "test_helper"

class TranscriptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
