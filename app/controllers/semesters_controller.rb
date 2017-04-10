# frozen_string_literal: true

class SemestersController < ApplicationController
  load_and_authorize_resource

  def update
    session[:semester_id] = @semester.id

    unless current_user.schedules_categories.for_semester(@semester).exists?
      scheduler.perform
    end

    redirect_to edit_user_registration_path,
                notice: "Changed to the #{@semester.semester} semester"
  end

  private

  def scheduler
    @schedules = Scheduler::Runner.new(
      user: current_user, semester: @semester.id
    )
  end
end
