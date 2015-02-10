class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :set_semester
  
  before_filter :only_yours
  
  def index
    @offerings = @user.schedules.where(semester: @active_semester).collect { |course| Offering.find(course.offering_id) }
    @day_hash = view_context.create_day_hash(@offerings)

    @schedules, @common_courses, @new_category_courses, @remaining_credits  = view_context.sched_algorithm(params[:user_id])
  end

  def new
    @schedules, @common_courses, @new_category_courses, @remaining_credits  = view_context.sched_algorithm(params[:user_id])
  end

  def create
    @schedules = []
    (params[:schedule][:offering_id].reject! { |c| c.empty? }).each do |oid|
      @schedules << @user.schedules.new do |s|
        s.user_id = @user.id
        s.offering_id = oid
      end
    end
    @current_schedules = @user.schedules.where(semester: @active_semester).collect { |sched| sched.offering_id }

    @errors = []
    @schedules.each do |c|
      @sch = Schedule.find_or_create_by(user_id: c.user_id, offering_id: c.offering_id, semester: @active_semester)
      if not @sch.errors.blank?
        @errors << @sch
      end
      @current_schedules -= [c.offering_id]
    end

    @current_schedules.each do |c|
      Schedule.where(user_id: @user.id, offering_id: c, semester: @active_semester).take.destroy
    end
    @user_schedules = Schedule.where(user_id: @user.id, semester: @active_semester)
    @day_hash2 = view_context.create_day_hash(@user_schedules.collect{ |course| Offering.find(course.offering_id) })
    respond_to do |format|
      format.js {@errors}
      format.html { redirect_to user_schedules_path(@user), notice: 'You succussfully signed up for courses' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_semester
      @active_semester = Semester.where(active: true).take
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:user_id, :schedule => [:offering_id])
    end
    
    def only_yours
      logged_in = User.find_by_id(session[:user_id])
      # going_to = User.find_by_id(params[:id])
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
