class SemestersController < ApplicationController
  before_action :set_active_semester, only: [:index, :update]
  before_action :set_selected_active, only: [:update]
  before_filter :authorize

  def index
    @semesters = (Semester.all.map { |semester| [semester.semester, semester.id] })
  end

  def new
    @semester = Semester.new
  end

  def update
    if @selected_active != @active_semester
      @selected_active.update(active: true)
      @active_semester.update(active: false)
    end
    
    respond_to do |format|
      format.html { redirect_to semesters_path, notice: @selected_active.semester + ' is now active' }
    end
  end

  def create
    @semester = Semester.new(semester_params)

    respond_to do |format|
      if @semester.save
       	flash[:notice] = @semester.semester + " has been created as a new semester!"
       	format.js { render :js => "window.location.href='"+semesters_path+"'"}
        format.html { redirect_to semesters_path, notice: @semester.semester + " has been created as a new semester!" }
        format.json { render :show, status: :created, location: @semester }
      else
        format.html { render :new }
        format.js {}
        format.json { render json: @semester.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_active_semester
      @active_semester = Semester.where(active: true).take
    end
    
    def set_selected_active
      @selected_active = Semester.find(params[:semester][:active])
    end 
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def semester_params
      params.require(:semester).permit(:semester)
    end
    
    def authorize
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_schedules_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end
