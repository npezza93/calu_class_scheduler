class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_active_semester
  before_action :set_session_semester

  def set_active_semester
    @active_semester ||= Semester.active
  end

  def set_session_semester
    if !session[:semester_id].blank?
      @session_semester = Semester.find(session[:semester_id])
    else
      @session_semester = @active_semester
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
