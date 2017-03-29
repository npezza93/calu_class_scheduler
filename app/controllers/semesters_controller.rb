# frozen_string_literal: true

class SemestersController < ApplicationController
  load_and_authorize_resource

  def update
    session[:semester_id] = @semester.id

    redirect_to edit_user_registration_path,
                notice: "Changed to the #{@semester.semester} semester"
  end
end
