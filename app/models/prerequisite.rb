class Prerequisite < ActiveRecord::Base
  belongs_to :prerequisite_group
  belongs_to :course

  validates :course, uniqueness: { scope: :prerequisite_group_id }

  # checking if yhe user completed all the required prereqs for a course
  # if they failed one of the prereqs it returns that course so they can retake
  # it. Returns nil if they are good to go.  
  def passed?(transcript, courses_taken)
    if courses_taken.include?(course) && passed_minimum_grade?(transcript)
      nil
    elsif courses_taken.include?(course) && !passed_minimum_grade?(transcript)
      course
    elsif !courses_taken.include?(course)
      false
    end
  end

  def passed_minimum_grade?(transcript)
    if !minimum_grade?
      true
    elsif minimum_grade == 'C'
      transcript.find { |t| t.course_id == course_id }.grade_c
    elsif minimum_grade == 'C-'
      transcript.find { |t| t.course_id == course_id }.grade_c_minus
    end
  end
end
