# frozen_string_literal: true
class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def account_update_params
    params.require(:user).permit(
      :password, :password_confirmation, :major_id, :pt_a, :pt_b, :pt_c, :pt_d,
      :first_name, :last_name, :email, :advised_by, minor: []
    )
  end
  alias sign_up_params account_update_params
end
