class UsersController < ApplicationController
  def index
    authorize! :index, User

    if (@students = User.search(params[:search])).nil?
      @students = current_user.advisees + current_user.students
    end

    @students = Kaminari.paginate_array(@students).page(params[:page]).per(15)
  end

  private

  def student_params
    params.require(:user).permit(
      :pt_a, :pt_b, :pt_c, :pt_d, minor: []
    )
  end
end
