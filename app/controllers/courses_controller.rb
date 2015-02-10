class CoursesController < ApplicationController
  before_action :set_course, only: [:destroy, :edit, :update]
  before_filter :authorize
  
  def index
    @courses = Course.all
  end
  
  def new
    @courses = Course.all.map { |course| [course.subject + course.course.to_s + ": " + course.title, course.id] }
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    @courses = Course.all.map { |course| [course.subject + course.course.to_s + ": " + course.title, course.id] }
  end

  def create
    @course = Course.new(course_params)
    @prereqs = []
    params[:course][:courses].each do |course_id|
      if course_id != ""
        @prereqs << Course.find_by_id(course_id)
      end
    end
    
    respond_to do |format|
      if @course.save
        @course.courses = @prereqs
        flash[:notice] = @course.title + " was successfully created!"
        format.js { render :js => "window.location = '/courses'" }
        format.html { redirect_to users_path, notice: @course.title + ' created' }
        format.json { render :show, status: :created, location: @course }
      else
        format.js { @errors = true}
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        @prereqs = []
        params[:course][:courses].each do |course_id|
          if course_id != ""
            @prereqs << Course.find_by_id(course_id)
          end
        end
        @course.courses = @prereqs
        flash[:notice] = @course.title + " was successfully updated!"
        format.js { render :js => "window.location = '/courses'" }
        format.html {redirect_to courses_path, notice: @course.subject + @course.course.to_s + 'successfully updated!' }
        format.json { render :index, status: :ok, location: @user }
      else
        format.js {@errors = true}
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: @course.title + ' was successfully destroyed.'  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:subject, :course, :title, courses: [:prerequisite_course_id])
    end
    
    def authorize
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_transcripts_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end
