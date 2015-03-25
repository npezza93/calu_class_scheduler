class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  before_action :set_session_user
  before_action :set_user
  before_action :set_semester
  
  before_filter :only_yours
  
  def index
    @offerings = @user.schedules.where(semester: @active_semester).collect { |course| Offering.find(course.offering_id) }
    @day_hash = view_context.create_day_hash(@offerings)
    @new_work_schedule = WorkSchedule.new
    @work_schedules = WorkSchedule.where(user: @user, semester: @active_semester)
    @work_time_slots = WorkDaysTime.all
    @majors = (Major.all.map { |major| [major.major, major.id] }) << ["", "-1"]
    @minors = (Major.all.map { |major| [major.major, major.id] if @user.major_id != major.id}).compact
  end

  def new
    @taken_courses, @category_courses   = scheduler(params[:user_id])
    @work_schedules = WorkSchedule.where(user: @user, semester: @active_semester)
    @schedules = @user.schedules.collect { |course| Offering.find(course.offering_id) }
    @offerings = (@category_courses.values.reduce Hash.new, :merge).values.flatten.map { |offering| offering.id }
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

    def prerequisite_check(courses, user_courses, user)
      ok_courses = []
      transcripts = Transcript.where(user: user)
      courses.each do |course|
        grouped_prerequisites = course.prerequisites.group_by(&:course_group_id)
        
        if not grouped_prerequisites.blank?
          grouped_prerequisites.each do |group_id, prereq_group|
            prereq_group.map! do |prereq| 
              passed, failed_grade = prereq_grade_checker(prereq, user_courses, transcripts)
              if passed 
                true
              else
                if failed_grade != nil
                  ok_courses << failed_grade
                end
                false
              end
            end
            grouped_prerequisites[group_id] = prereq_group.inject(:&)
          end
          
          if course.minimum_pt != "" or course.minimum_pt != nil
            if grouped_prerequisites.values.inject(:|) and class_standing_compare(user.class_standing,course.minimum_class_standing) and sat_check(user, course.minimum_sat_score)
              ok_courses << course
            end
          else
            if grouped_prerequisites.values.inject(:|) or pt_check(user, course.minimum_pt) or sat_check(user, course.minimum_sat_score)
              ok_courses << course
            end
          end
        else
          if course.minimum_pt != "" or course.minimum_pt != nil
            if class_standing_compare(user.class_standing,course.minimum_class_standing) and sat_check(user, course.minimum_sat_score)
              ok_courses << course
            end
          else
            if pt_check(user, course.minimum_pt) or sat_check(user, course.minimum_sat_score)
              ok_courses << course
            end
          end
        end
      end
      return ok_courses
    end
    
    def scheduler(uid) 
      user = User.find(uid)
      used_courses = Set.new

      active_semester = Semester.where(active: true).take
      user_courses = Transcript.where(user_id: uid).map { |transcript| transcript.course } 
      
      categories = CurriculumCategory.where(major: user.major , minor: false).group_by(&:id).flatten.flatten  
      user.minor.each do |minor|
        categories += CurriculumCategory.where(major: minor , minor: true).group_by(&:id).flatten.flatten  
      end
      
      category_courses = categories.map { |category| (category.is_a?(CurriculumCategory)) ? category.curriculum_category_sets.group_by(&:id) : category }
      category_courses = Hash[*category_courses]
      
      category_courses.each do |category_id, sets|
        sets.each do |set_id, category_sets|
          category_sets.map! do |category_course|
            temp_courses = []
            category_course.course_set.each do |set_course|
              temp_courses << set_course.course
            end
            temp_courses
          end
        end
      end
      
      category_courses.each do |category_id, sets|
        sets.each do |set_id, category_sets|
          category_sets.flatten!
        end
      end
      
      category_courses_tf = deep_copy(category_courses)
      taken_courses = deep_copy(category_courses)
      
      category_courses_tf.each do |category_id, sets|
        if not sets.blank?
          sets.each do |set_id, set_courses|
            set_courses.map! { |set_course| (user_courses.include?(set_course)) ? true : false }
          end
        else 
          category_courses_tf[category_id] = true
        end
      end
      
      complete_sets = []
      category_courses_tf.each do |category_id, sets|
        if sets.class.name == "Hash"
          sets.each do |set_id, set_courses|
            count = CurriculumCategorySet.find(set_id).count
            if count != nil and set_courses.grep(true).count != count
              category_courses_tf[category_id][set_id] = false
            elsif count != nil and set_courses.grep(true).count == count
              category_courses_tf[category_id][set_id] = true
            elsif count == nil
              category_courses_tf[category_id][set_id] = set_courses.inject(:&)
            end
          end
          complete_sets <<  sets.select {|k,v| v }
          CurriculumCategory.find(category_id).set_and_or_flag ? category_courses_tf[category_id] = sets.values.inject(:|) : category_courses_tf[category_id] = sets.values.inject(:&)
        end
      end  
      
      complete_sets.map!(&:keys).flatten!
      category_courses_tf.keys.each { |key| category_courses_tf[key] ? category_courses_tf.delete(key) : false }
      cats_unmet = category_courses_tf.keys
      category_courses.select! {|k,v| cats_unmet.include?(k) }
      
      category_courses.each do |category_id, sets|
        sets.each do |set_id, set_courses|
          category_courses[category_id][set_id] = set_courses - user_courses
        end
        sets.keys.each { |key| complete_sets.include?(key) ? sets.delete(key) : false }
        if CurriculumCategory.find(category_id).set_and_or_flag 
          temp = Hash.new
          sets.each do |set_id, set_courses|
            temp[set_id] = set_courses.count
          end
          min = temp.min.uniq[0]
          temp.select! {|k,v| v > min }
          sets.keys.each { |key| temp.keys.include?key ? sets.delete(key) : false }
        end
      end
      
      needs_list = []
      category_courses.each do |category_id, sets|
        sets.each do |set_id, set_courses|
          category_courses[category_id][set_id] = prerequisite_check(set_courses, user_courses, user)
        end
        set_offerings = []
        sets.each do |set_id, set_courses|
          set_offerings = []
          set_courses.each do |set_course|
            if used_courses.add?(set_course)
              offerings = Offering.where(course: set_course, semester: active_semester).flatten
              if offerings.blank?
                needs_list << set_course
              else
                set_offerings << offerings
              end
            end
          end
          category_courses[category_id][set_id]  = set_offerings.flatten
        end
      end
      
      needs_list.flatten!
      NeededCourse.where(user: user, semester: active_semester).delete_all
      inserts = []
      needs_list.each do |course|
        inserts.push "(" + user.id.to_s+ ", " + course.id.to_s + "," + active_semester.id.to_s + ")"
      end
      sql = "INSERT INTO needed_courses (\"user_id\", \"course_id\", \"semester_id\") VALUES #{inserts.join(", ")}"
      (ActiveRecord::Base.connection).execute sql
      
      taken_courses.each do |category_id, sets|
        sets.each do |set_id, set_courses|
          taken_courses[category_id][set_id] = set_courses & user_courses
        end
        if CurriculumCategory.find(category_id).set_and_or_flag 
          if not category_courses_tf.keys.include?category_id
            first_complete = sets.keys.detect { |key| complete_sets.include?(key) }
            sets.keys.each { |key| first_complete != key ? sets.delete(key) : false }
          else
            t = Hash.new
            t[1] =sets.values.flatten.uniq
            taken_courses[category_id] =t
          end
        end
      end

      return taken_courses, category_courses
    end
    
    def deep_copy(o)
      Marshal.load(Marshal.dump(o))
    end
    
    def class_standing_compare(users_standing, min_standing)
      if min_standing == nil
        return true
      elsif users_standing == nil
        return false
      else
        standings = {1 => "Senior", 2 => "Junior", 3 => "Sophmore", 4 => "Freshman" }
        users = standings.select { |k,v| v.include? users_standing }
        min = standings.select { |k,v| v.include? min_standing }
        if users.keys[0] <= min.keys[0]
          return true
        else 
          return false
        end
      end
    end
    
    def sat_check(user, min_sat)
      if min_sat == "" or min_sat == nil
        return true
      elsif min_sat == "520"
        if user.sat_520
          return true
        else
          return false
        end
      elsif min_sat == "580"
        if user.sat_580
          return true
        else
          return false
        end
      elsif min_sat == "700"
        if user.sat_700
          return true
        else
          return false
        end
      elsif min_sat == "640"
        if user.sat_640
          return true
        else
          return false
        end
      elsif min_sat == "440"
        if user.sat_440
          return true
        else
          return false
        end
      end
    end
    
    def prereq_grade_checker(prereq, user_courses, transcripts)
      if user_courses.include?(prereq.prerequisite_course)
        if (prereq.minimum_grade == nil) or (prereq.minimum_grade == "C" and transcripts.where(course: prereq.prerequisite_course).take.grade_c) or (prereq.minimum_grade == "C-" and transcripts.where(course: prereq.prerequisite_course).take.grade_c_minus)
          return true, nil
        else 
          return false, prereq.prerequisite_course
        end
      else 
        return false, nil
      end
    end
    
    def pt_check(user, min_pt)
      case min_pt
      when "A"
        user.pt_a == 1 ? true : false
      when "B"
        user.pt_b == 1 ? true : false
      when "C"
        user.pt_c == 1 ? true : false
      when "D"
        user.pt_d == 1 ? true : false
      else
        false
      end
    end
end
