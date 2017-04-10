# frozen_string_literal: true

# == Schema Information
#
# Table name: prerequisites
#
#  id                    :integer          not null, primary key
#  course_id             :integer
#  created_at            :datetime
#  updated_at            :datetime
#  prerequisite_group_id :integer
#  minimum_grade         :string(255)
#

class Prerequisite < ApplicationRecord
  belongs_to :prerequisite_group
  belongs_to :course

  validates :course, uniqueness: { scope: :prerequisite_group_id }
  validates :minimum_grade, inclusion: { in: ["C", "C-"] }, allow_nil: true

  # checking if the user completed all the required prereqs for a course
  # if they failed one of the prereqs it returns that course so they can retake
  # it. Returns nil if they are good to go.
  def passed?(transcript, courses_taken)
    return false unless courses_taken.include?(course_id)

    passed_minimum_grade?(transcript)
  end

  def passed_minimum_grade?(transcript)
    return true unless minimum_grade?

    transcript.find { |t| t.course_id == course_id }.send(c_or_c_minus_method)
  end

  def failed_course(transcript, courses_taken)
    return unless courses_taken.include?(course_id)

    return course unless passed_minimum_grade?(transcript)
  end

  private

  def c_or_c_minus_method
    if minimum_grade == "C"
      "grade_c"
    elsif minimum_grade == "C-"
      "grade_c_minus"
    end
  end
end
