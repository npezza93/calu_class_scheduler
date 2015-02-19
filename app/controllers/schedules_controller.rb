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
    
    def sched_algorithm(uid) 
      @schedule = Schedule.new
      @category_courses = Hash.new
      @common_courses = Hash.new
      @category_credits = Hash.new
      @class_hash = Hash.new
      @remaining_credits = Hash.new

      @user_courses = Transcript.where(user_id: uid).collect(&:course_id)
           
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
end
