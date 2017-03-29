# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def current_semester
    return @current_semester if defined?(@current_semester)

    @current_semester =
      if session[:semester_id]
        Semester.find_by(id: session[:semester_id]) || Semester.active
      else
        Semester.active
      end
  end
  helper_method :current_semester
end
