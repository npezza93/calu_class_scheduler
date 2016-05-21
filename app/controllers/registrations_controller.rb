class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :first_name, :last_name, :email,
      :password, :password_confirmation, :major_id, :advised_by, minor: []
    )
  end

  def account_update_params
    params.require(:user).permit(
      :password, :password_confirmation, :major_id, :pt_a, :pt_b, :pt_c, :pt_d,
      :avatar, :advised_by, minor: []
    )
  end
end
