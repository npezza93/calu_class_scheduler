# frozen_string_literal: true

module SchedulesHelper
  def course_hidden?(course_offerings, hidden_ids)
    course_offerings.count do |offering|
      hidden_ids.include? offering.id
    end == course_offerings.count
  end
end
