# frozen_string_literal: true

class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @students = current_user.advisees
  end

  def show
    @schedule_approval =
      @user.schedule_approvals.for_semester(current_semester).first
  end
end
