# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :index, User

    @students = current_user.advisees.page(params[:page]).per(15)
  end
end

#   private
#
#   def student_params
#     params.require(:user).permit(
#       :pt_a, :pt_b, :pt_c, :pt_d, minor: []
#     )
#   end
