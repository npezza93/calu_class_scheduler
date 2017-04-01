# frozen_string_literal: true

module UserContextHelper
  def current_semester
    @current_semester ||=
      if session[:semester_id]
        Semester.find_by(id: session[:semester_id]) || Semester.active
      else
        Semester.active
      end
  end

  def current_semester_id
    @current_semester ||=
      if session[:semester_id]
        session[:semester_id]
      else
        Semester.active.id
      end
  end
end
