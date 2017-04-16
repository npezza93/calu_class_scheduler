# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
    reset_schedules(resource) if resource.reset
  end

  private

  def account_update_params
    params.require(:user).permit(
      :password, :password_confirmation, :major_id, :pt_a, :pt_b, :pt_c, :pt_d,
      :first_name, :last_name, :email, :advised_by, :advisor, minor: []
    )
  end
  alias sign_up_params account_update_params

  def reset_schedules(user)
    user.schedules.for_semester(current_semester_id).destroy_all
    user.schedules_categories.for_semester(current_semester_id).destroy_all

    Scheduler::Runner.new(user: user, semester: current_semester_id).perform
  end
end
