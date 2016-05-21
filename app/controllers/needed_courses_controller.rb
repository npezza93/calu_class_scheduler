class NeededCoursesController < ApplicationController
  def index
    needed_courses = NeededCourse.all.collect(&:course_id)
    @needed_course_count = Hash[*needed_courses.collect do |v|
      [Course.find(v), NeededCourse.where(course_id: v).count]
    end.flatten]
  end
end
