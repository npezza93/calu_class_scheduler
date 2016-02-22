class CoursesController < ApplicationController
  before_action :set_course, only: [:destroy, :edit, :update]

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
    @pt_options = [["Passing Part A of the Math Placement Exam", "A"],["Passing Part B of the Math Placement Exam", "B"],["Passing Part C of the Math Placement Exam", "C"],["Passing Part D of the Math Placement Exam(7-9)", "D-"],["Passing Part D of the Math Placement Exam(10 or above)", "D"]]
    @years = ["Senior", "Junior", "Sophmore", "Freshman"]
    @sat_scores = [["440 on Mathematics or better", "440"], ["520 on Mathematics or better","520"], ["580 on Mathematics or better","580"], ["640 on Mathematics or better","640"], ["700 on Mathematics or better","700"]]
  end

  def create
    groups = (course_params[:prerequisites]).join("_").split("__").map{ |group| group.split("_").reject(&:empty?) }
    temp_params = course_params
    temp_params.delete("prerequisites")
    @course = Course.new(temp_params)
    min_grade_i =0
    prereq_min_grades = params["prereq_grades"].split("/|/")
    prereq_min_grades.map! { |grade| (grade == "N/A") ? nil : grade }

    @prereqs = []
    groups.each_with_index do |group, index|
      group.each do |course_id|
        @prereqs << Prerequisites.new(prerequisite_course_id: course_id, course_group_id: (index+1), minimum_grade: prereq_min_grades[min_grade_i])
        min_grade_i += 1
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

    min_grade_i =0
    prereq_min_grades = params["prereq_grades"].split("/|/")
    prereq_min_grades.map! { |grade| (grade == "N/A") ? nil : grade }

    respond_to do |format|
      if @course.update(temp_params)
        @prereqs = []
        groups.each_with_index do |group, index|
          group.each do |course_id|
            @prereqs << Prerequisites.new(prerequisite_course_id: course_id, course_group_id: (index+1), minimum_grade: prereq_min_grades[min_grade_i])
            min_grade_i += 1
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
    Prerequisites.where(parent_course_id: @course.id).delete_all
    Prerequisites.where(prerequisite_course_id: @course.id).delete_all
    CourseSet.where(course_id: @course.id).delete_all
    Offering.where(course_id: @course.id).delete_all
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: @course.title + ' was successfully destroyed.'  }
      format.json { head :no_content }
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(
      :subject, :course, :title, :credits, :minimum_class_standing,
      :minimum_sat_score, :minimum_pt, prerequisites: []
    )
  end
end
