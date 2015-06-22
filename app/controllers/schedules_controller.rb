class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  before_action :set_session_user
  before_action :set_user
  before_action :set_semester
  
  before_filter :only_yours
  
  def index
    @signed_up_for = @user.offerings.where(semester: @active_semester).includes(:days_time, :course)
    @day_hash = view_context.create_day_hash(@signed_up_for)
    @new_work_schedule = WorkSchedule.new
    @work_time_slots = WorkDaysTime.order(:start_time).group_by(&:days)
    @majors = Major.all
    @minors = Major.where.not(id: @user.major_id)

    @transcript = Transcript.new
    @transcripts = @user.transcripts.includes(:course)
    @courses = Course.all.order(:subject)
    @letter_grades = ["A","A-", "B+", "B", "B-", "C+", "C","C-", "D-","D","D+", "F"]

    @completed_category_courses, @incomplete_category_courses = @user.scheduler

    @work_schedules = @user.work_schedules.includes(:work_days_time)
    @schedules = @user.offerings
    @offerings = @incomplete_category_courses.values.flatten.collect(&:id)
  end

  def new
    @completed_category_courses, @incomplete_category_courses = @user.scheduler

    @work_schedules = @user.work_schedules.includes(:work_days_time)
    @schedules = @user.offerings
    @offerings = @incomplete_category_courses.values.flatten.collect(&:id)
    render :layout => false
  end

  def create
    Schedule.delete_all(user: @user, semester: @active_semester)

    @errors = []
    (params[:schedule][:offering_id].reject! { |c| c.empty? }).each do |oid|
      if not (sch = Schedule.create(user_id: @user.id, offering_id: oid, semester: @active_semester))
        @errors << sch
      end
    end

    @offerings = @user.schedules.where(semester: @active_semester).collect { |course| Offering.find(course.offering_id) }

    respond_to do |format|
      format.js {@errors}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session_user
      @session_user = User.find(session[:user_id])
    end
    
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def set_user
      @user = User.includes(:major, transcripts: {course: :prerequisites}, offerings: [:course, :days_time]).find(params[:user_id])
    end
    
    def set_semester
      @active_semester = Semester.where(active: true).take
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:user_id, :schedule => [:offering_id])
    end
    
    def only_yours
      logged_in = User.find(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        unless params[:user_id].to_i == session[:user_id].to_i
          redirect_to user_transcripts_path(logged_in)
        end
      else
        if User.find_by_id(params[:user_id]).advisor or User.find_by_id(params[:user_id]).administrator
          redirect_to users_path, notice: "Admins and Advisors don't have transcripts!"
        end
      end
    end
end
