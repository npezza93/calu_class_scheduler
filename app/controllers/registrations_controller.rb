# Devise registrations controller
# needed to add additional params when signing up
class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :first_name, :last_name, :email,
      :password, :password_confirmation, :major_id, :advised_by
    )
  end

  def account_update_params
    params.require(:user).permit(
      :password, :password_confirmation, :major_id, :avatar, :advised_by
    )
  end
end
