# Devise registrations controller
# needed to add additional params when signing up
class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(
      :first_name, :last_name, :email,
      :password, :password_confirmation, :major_id, :advised_by
    )
  end

  def account_update_params
    params.require(:user).permit(
      :password, :password_confirmation, :current_password, :avatar
    )
  end
end
