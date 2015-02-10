class TranscriptsController < ApplicationController
  before_action :set_user, only: [:create, :index, :import, :destroy]
  before_action :set_new_transcript, only: [:index]
  before_action :set_transcript, only: [:destroy]
  before_action :set_active_semester
  before_action :get_ext, only: [:import]
  before_filter :only_yours
  
  def index
    @transcripts = @user.transcripts.all
    @courses = (Course.all.order(:course).map { |course| [course.subject + course.course.to_s + ": " + course.title, course.id] }) << ["",-1]
  end
  
  def create
    @transcript = @user.transcripts.create(transcript_params)
    @transcript.user = @user
    
    if (Schedule.where(user: @user, semester: @active_semester).collect { |c| c.offering.course.id }).include?(@transcript.course_id)
      Schedule.where(user: @user, offering_id: (Offering.where(course_id: @transcript.course_id, semester: @active_semester).take.id)).take.destroy
    end
    @offerings = Schedule.where(user: @user, semester: @active_semester).collect { |c| c.offering }
    @day_hash = view_context.create_day_hash(@offerings)

    respond_to do |format|
      if @transcript.save
        format.html { redirect_to user_transcripts_path, notice: "you have taken this course" }
        format.js {@schedules, @common_courses, @new_category_courses, @remaining_credits  = view_context.sched_algorithm(@user.id) }
      else
        format.html { render :index }
        format.js { @errors = true }
      end
    end
  end

  def import
    if @ext == ".pdf"
      @bad_courses = Transcript.import(import_params, @user.id)
      respond_to do |format|
        format.html { redirect_to user_schedules_path(@user), notice: "Transcript Uploaded successfullly!" }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_schedules_path(@user), notice: "Only PDF files are accepted!" }
      end
    end
  end

  def destroy
    @transcript.destroy
    respond_to do |format|
      format.html { redirect_to user_schedules_path(@user), notice: @transcript.course.title + " removed!" }
      format.js {}
    end
  end
  
  private
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_new_transcript
      @transcript = Transcript.new
    end

    def set_transcript
      @transcript = Transcript.find(params[:id])
    end
    
    def set_active_semester
      @active_semester = Semester.where(active: true).take
    end
    
    def get_ext
      @ext = (File.extname(params[:transcript_file].original_filename)).downcase 
    end
    
    def transcript_params
      params.require(:transcript).permit(:course_id, :grade)
    end
    
    def import_params
      params.require(:transcript_file)
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