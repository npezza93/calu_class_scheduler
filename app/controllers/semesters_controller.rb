class SemestersController < ApplicationController
  def index
  end

  def new
    @semester = Semester.new
  end

  def system
    @active_semester.update_attributes(active: false)
    @active_semester = Semester.find(semester_params[:id])
    @active_semester.update_attributes(active: true)

    redirect_to semesters_path,
                notice: @active_semester +
                        ' is now the active semeter for the system'
  end

  def set_session
    session[:semester_id] = semester_params[:id]
    @session_semester = Semester.find(session[:semester_id])

    redirect_to semesters_path,
                notice: @session_semester + ' is now viewable'
  end

  def create
    @semester = Semester.new(semester_params)

    if @semester.save
      redirect_to semesters_path,
                  notice: @semester.semester +
                          ' has been created as a new semester!'
    else
      render :new
    end
  end

  private

  def semester_params
    params.require(:semester).permit(:id)
  end
end
