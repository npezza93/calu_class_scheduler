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

  # checking if the user completed all the required prereqs for a course
  # if they failed one of the prereqs it returns that course so they can retake
  # it. Returns nil if they are good to go.
  def passed?(transcript, courses_taken)
    return false unless courses_taken.include?(course)

    if passed_minimum_grade?(transcript)
      nil
    elsif !passed_minimum_grade?(transcript)
      course
    end
  end

  def passed_minimum_grade?(transcript)
    if !minimum_grade?
      true
    elsif c_or_c_minus_method
      transcript.find { |t| t.course_id == course_id }.send(c_or_c_minus_method)
    end
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
