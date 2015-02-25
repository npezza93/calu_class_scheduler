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
    @prereqs = @course.prerequisites.group_by(&:course_group_id)
    @max_group_id = @prereqs.keys.max
    if @max_group_id == nil
      @max_group_id = 1
    end
    @courses = Course.all.map { |course| [course.subject + course.course.to_s + ": " + course.title, course.id] }
  end

  def create
    groups = (course_params[:prerequisites]).join("_").split("__").map{ |group| group.split("_").reject(&:empty?) }
    temp_params = course_params
    temp_params.delete("prerequisites")
    @course = Course.new(temp_params)
    
    @prereqs = []
    groups.each_with_index do |group, index|
      group.each do |course_id|
        @prereqs << Prerequisites.new(prerequisite_course_id: course_id, course_group_id: (index+1))
      end
    end

    respond_to do |format|
      if @course.save
        @course.prerequisites = @prereqs
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
    groups = (course_params[:prerequisites]).join("_").split("__").map{ |group| group.split("_").reject(&:empty?) }
    temp_params = course_params
    temp_params.delete("prerequisites")
    
    respond_to do |format|
      if @course.update(temp_params)
        @prereqs = []
        groups.each_with_index do |group, index|
          group.each do |course_id|
            @prereqs << Prerequisites.new(prerequisite_course_id: course_id, course_group_id: (index+1))
          end
        end
        @course.prerequisites = @prereqs
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
      params.require(:course).permit(:subject, :course, :title, :credits, {:prerequisites => []})
    end
    
    def authorize
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_transcripts_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end
