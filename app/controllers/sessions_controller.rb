# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    if params[:guest].to_i == 1
      user = create_guest

      sign_in(resource_name, user)
      respond_with user, location: after_sign_in_path_for(user)
    else
      super
    end
  end

  def destroy
    current_user.destroy if current_user.guest?
    super
  end

  private

  def create_guest
    password = SecureRandom.hex

    User.create(
      email: "guest@caluadvisor.com",
      password: password,
      password_confirmation: password,
      first_name: "Guest",
      last_name: "Guest",
      major: Major.find_by(major: "Computer Science"),
      guest: true
    )
  end
end
