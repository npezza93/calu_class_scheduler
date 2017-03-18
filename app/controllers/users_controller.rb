# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :show

  def index
    authorize! :index, User

    @students = current_user.advisees
  end

  def show
  end

  private

  def set_user
    @student = User.find(params[:id])
  end
end
