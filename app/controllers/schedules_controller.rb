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
    @minors = (Major.all.map { |major| [major.major, major.id] if @user.major_id != major.id})
  end

  def new
    @schedules, @common_courses, @new_category_courses, @remaining_credits  = sched_algorithm(params[:user_id])
    @work_schedules = WorkSchedule.where(user: @user, semester: @active_semester)
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

    def toposort(data)
        sorted =[]
        
        until data.length == 0
            temp = []
            data.each do |k, v|
                if v.empty?
                    temp << k
                end
            end
            
            sorted << temp
            
            temp.each do |k|
                data.delete(k)
                
                data.each do |key, val|
                    if val.include?(k)
                        val.delete(k)
                    end
                end
            end
        end
      sorted
    end
    
    def prerequisite_check(courses, user_courses)
      ok_courses = []
      courses.each do |course|
        grouped_prerequisites = course.prerequisites.group_by(&:course_group_id)
        
        grouped_prerequisites.each do |group_id, prereq_group|
          prereq_group.map! { |prereq| prereq.prerequisite_course }
        end
        
        grouped_prerequisites.each do |group_id, prereq_group|
          prereq_group.map! { |prereq| user_courses.include?(prereq) ? true : false }
          prereq_group[group_id] = prereq_group.inject(:&)
        end
        
        if grouped_prerequisites.values.inject(:|) 
          ok_courses << course
        end
      end
      return ok_courses
    end
    
    def sched_algorithm(uid) 
      user = User.find(uid)

      user_courses = Transcript.where(user_id: 7).map { |transcript| transcript.course } 
      
      categories = CurriculumCategory.where(major: 1 , minor: false).group_by(&:id).flatten.flatten  
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
      
      category_courses_tf.each do |category_id, sets|
        sets.each do |set_id, set_courses|
          set_courses.map! { |set_course| (user_courses.include?(set_course)) ? true : false }
        end
      end
      
      complete_sets = []
      category_courses_tf.each do |category_id, sets|
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

      category_courses.each do |category_id, sets|
        sets.each do |set_id, set_courses|
          category_courses[category_id][set_id] = prerequisite_check(set_courses, user_courses)
        end
      end
    







      CurriculumCategory.where(major: User.find(uid).major_id, minor: false).each do |category|
         @category_courses[category.id] = category.curriculum_category_courses.collect(&:course_id)
         category.curriculum_category_courses.each do |course|
           @class_hash[course.course_id] = Set.new (course.course.courses.collect(&:id))
         end
         @common_courses[category.id] = ((@category_courses[category.id] & @user_courses).collect { |c_id| Course.find(c_id) }).sort! { |a,b| b.course <=> a.course }
         @category_credits[category.id] = (@common_courses[category.id].collect { |c| Course.find(c).credits }).inject(:+)
         
         if @category_credits[category.id] != nil
           @remaining_credits[category.id] = category.required_amount_of_credits - @category_credits[category.id]
         else
            @remaining_credits[category.id] = category.required_amount_of_credits
         end
        
         if @category_credits[category.id] and ((@category_credits[category.id] - category.required_amount_of_credits) >= 0)
            @category_credits.delete(category.id)
         end
      end
      
      User.find(uid).minor.each do |minor_id|
        CurriculumCategory.where(major: minor_id, minor: true).each do |category|
           @category_courses[category.id] = category.curriculum_category_courses.collect(&:course_id)
           category.curriculum_category_courses.each do |course|
             @class_hash[course.course_id] = Set.new (course.course.courses.collect(&:id))
           end
           @common_courses[category.id] = ((@category_courses[category.id] & @user_courses).collect { |c_id| Course.find(c_id) }).sort! { |a,b| b.course <=> a.course }
           @category_credits[category.id] = (@common_courses[category.id].collect { |c| Course.find(c).credits }).inject(:+)
           
           if @category_credits[category.id] != nil
             @remaining_credits[category.id] = category.required_amount_of_credits - @category_credits[category.id]
           else
              @remaining_credits[category.id] = category.required_amount_of_credits
           end
          
           if @category_credits[category.id] and ((@category_credits[category.id] - category.required_amount_of_credits) >= 0)
              @category_credits.delete(category.id)
           end
        end    
      end
      
      @categories_left = @category_credits.keys
      
      @user_courses.each do |c|
        @class_hash.delete(c)
        
        keys = @class_hash.keys
        keys.each do |key|
          @class_hash[key] = (@class_hash[key].to_a - [c]).to_set
        end
      end
  
      @sorted = toposort(@class_hash)[0]
      
      @new_category_courses = Hash.new
      @categories_left.each do |cat|
          @new_category_courses[cat] = @category_courses[cat] & @sorted
      end
        
        NeededCourse.where(user_id: uid, semester: Semester.where(active: true).take).destroy_all
      @new_category_courses.values.flatten.each do |course_id|
          if not Offering.where(course_id: course_id, semester: Semester.where(active: true).take).exists?
              NeededCourse.create(user_id: uid, semester: Semester.where(active: true).take, course_id: course_id)
          end
      end
          
      
      @new_category_courses.each do |k, v|
        x= []
        v.each do |id|
          Offering.where(course_id: id, semester: Semester.where(active: true).take).each do |offering|
            x << offering
          end
        end
        @new_category_courses[k] = x
      end

      @schedules = @user.schedules.collect { |course| Offering.find(course.offering_id) }
      
      return @schedules, @common_courses, @new_category_courses, @remaining_credits
    end
    
    
    def deep_copy(o)
      Marshal.load(Marshal.dump(o))
    end
end
