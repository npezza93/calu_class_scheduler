# frozen_string_literal: true
class SemestersController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def index
  end

  def new
    @semester = Semester.new
  end

  def update
    active_semester.update_attributes(active: false)
    active_semester = Semester.find(semester_params[:id])
    active_semester.update_attributes(active: true)

    redirect_to semesters_path,
                notice: active_semester.semester +
                        " is now the active semeter for the system"
  end

  def create
    @semester = Semester.new(semester_params)

    if @semester.save
      flash[:notice] =
        @semester.semester + " has been created as a new semester!"
      redirect_to semesters_path
    else
      render :new
    end
  end

  private

  def semester_params
    params.require(:semester).permit(:id, :semester)
  end
end
