class UsersController < ApplicationController
  before_action :set_active_semester, only: [:update]

  def index
    @students = Kaminari.paginate_array(
      if !params[:search].blank?
        User.search(current_user, params[:search])
      else
        User.advisees(current_user) + User.students(current_user)
      end).page(params[:page]).per(15)
  end

  private

  def set_active_semester
    @active_semester = Semester.where(active: true).take
  end

  def advisor_student_params
    params.require(:user).permit(
      :advised_by, :advisor, :pt_a, :pt_b, :pt_c, :pt_d
    )
  end

  def student_params
    params.require(:user).permit(
      :password, :password_confirmation, :major_id,
      :pt_a, :pt_b, :pt_c, :pt_d, minor: []
    )
  end
end
