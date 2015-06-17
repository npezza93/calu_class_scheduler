class TranscriptsController < ApplicationController
  before_action :set_user, only: [:create, :index, :import, :destroy]
  before_action :set_transcript, only: [:destroy]
  before_action :set_active_semester, only: [:create, :import]
  before_filter :only_yours
  before_action :set_session_user
  
  def index
    @transcript = Transcript.new
    @transcripts = @user.transcripts.includes(:course)
    @courses = Course.all.order(:subject)
    @letter_grades = ["A","A-", "B+", "B", "B-", "C+", "C","C-", "D-","D","D+", "F"]
    render layout: false
  end
  
  def create
    c_minus, c = grade_checker(transcript_params[:grade_c])

    @transcript = @user.transcripts.new do |t|
      t.grade_c = c
      t.grade_c_minus = c_minus
      t.course_id = transcript_params[:course_id]
    end
    
    @index_reload_flag = false
    if @user.courses.include?(@transcript.course)
      Schedule.where(user: @user, offering_id: (Offering.where(course_id: @transcript.course_id, semester: @active_semester).take.id)).take.destroy
      @index_reload_flag = true
    end

    respond_to do |format|
      if @transcript.save
        @work_schedules = @user.work_schedules.includes(:work_days_time)
        @schedules = @user.offerings

        if @index_reload_flag
          @signed_up_for = @user.offerings.where(semester: @active_semester).includes(:days_time, :course)
          @day_hash = view_context.create_day_hash(@signed_up_for)
          @new_work_schedule = WorkSchedule.new
          @work_time_slots = WorkDaysTime.order(:start_time).group_by(&:days)
        end
    
        format.html { redirect_to user_transcripts_path, notice: "you have taken this course" }
        format.js { @index_reload_flag}
      else
        format.html { render :index }
        format.js { @errors = true }
      end
    end
  end

  def import
    if Transcript.import(params["Transcript"], @user.id)
      @signed_up_for = @user.offerings.where(semester: @active_semester).includes(:days_time, :course)
      @day_hash = view_context.create_day_hash(@signed_up_for)
      @new_work_schedule = WorkSchedule.new
      @work_time_slots = WorkDaysTime.order(:start_time).group_by(&:days)
      @work_schedules = @user.work_schedules.includes(:work_days_time)
      @schedules = @user.offerings
      @transcript = Transcript.new
      @transcripts = @user.transcripts.includes(:course)
      @courses = Course.all.order(:subject)
      @letter_grades = ["A","A-", "B+", "B", "B-", "C+", "C","C-", "D-","D","D+", "F"]
      
      Schedule.where(user: @user, semester: @active_semester).destroy_all
      
      respond_to do |format|
        format.js {}
        format.html { redirect_to user_schedules_path(@user), notice: "Transcript Uploaded successfullly!" }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_schedules_path(@user), notice: "Please Upload Correct Text!" }
        format.js { @error = "Please Upload Correct Text!" }
      end
    end
  end

  def destroy
    @completed_category_courses, @incomplete_category_courses = @user.scheduler

    @work_schedules = @user.work_schedules.includes(:work_days_time)
    @schedules = @user.offerings
    @offerings = @incomplete_category_courses.values.flatten.collect(&:id)

    @transcript.destroy
    respond_to do |format|
      format.html { redirect_to user_schedules_path(@user), notice: @transcript.course.title + " removed!" }
      format.js {}
    end
  end
  
  private
    def set_session_user
      @session_user = User.find(session[:user_id])
    end

    def set_user
      @user = User.includes(:courses, :taken_courses, :work_schedules).find(params[:user_id])
    end

    def set_transcript
      @transcript = Transcript.find(params[:id])
    end
    
    def set_active_semester
      @active_semester = Semester.where(active: true).take
    end
    
    def transcript_params
      params.require(:transcript).permit(:course_id, :grade_c)
    end
    
    def import_params
      params.require(:transcript_file)
    end
    
    def only_yours
      logged_in = User.find_by_id(session[:user_id])
      if not logged_in.advisor
        unless params[:user_id].to_i == session[:user_id].to_i
          redirect_to user_schedules_path(logged_in)
        end
      else
        if User.find_by_id(params[:user_id]).advisor
          redirect_to users_path, notice: "Advisors don't have transcripts!"
        end
      end
    end
    
    def grade_checker(grade)
      grades = ["A","A-", "B+", "B", "B-", "C+", "C","C-", "D-","D","D+", "F"]
      if grade == nil or grades.index(grade) >= 8
        return false, false
      else
        if grades.index(grade) <= 6
          return true, true
        elsif grades.index(grade) == 7
          return true, false
        end
      end
    end
end