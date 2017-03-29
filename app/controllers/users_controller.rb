# frozen_string_literal: true

class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @students = current_user.advisees
  end

  def show
  end
end
