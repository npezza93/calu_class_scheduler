class NeededCoursesController < ApplicationController
  before_filter :authorize
  def index
    needed_courses = NeededCourse.all.collect(&:course_id)
    @needed_course_count = Hash[ *needed_courses.collect { |v| [ Course.find(v), NeededCourse.where(course_id: v).count ] }.flatten ]
  end
  
  private
    def authorize
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_transcripts_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end
