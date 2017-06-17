# frozen_string_literal: true

class SemestersController < ApplicationController
  load_and_authorize_resource

  def update
    session[:semester_id] = @semester.id

    scheduler.perform if !current_user.advisor? && scheduler.present?

    redirect_to edit_user_registration_path,
                notice: "Changed to the #{@semester.semester} semester"
  end

  private

  def scheduler
    return if current_user.schedules_categories.for_semester(@semester).exists?

    @schedules = Scheduler::Runner.new(
      user: current_user, semester: @semester.id
    )
  end
end
