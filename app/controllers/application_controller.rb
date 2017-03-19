# frozen_string_literal: true
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def active_semester
    @active_semester ||= Semester.active
  end
  helper_method :active_semester

  def current_semester
    @current_semester ||=
      Semester.find_by(id: session[:semester_id]) || active_semester
  end
  helper_method :current_semester
end
