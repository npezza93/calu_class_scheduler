class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_filter :only_yours
  
  def index
    @offerings = @user.schedules.collect { |course| Offering.find(course.offering_id) }
    @day_hash = create_day_hash(@offerings)

    @schedules, @common_courses, @new_category_courses, @remaining_credits  = sched_algorithm(params[:user_id])
  end

  def new
    @schedules, @common_courses, @new_category_courses, @remaining_credits  = sched_algorithm(params[:user_id])
  end

  def create
    @schedules = []
    (params[:schedule][:offering_id].reject! { |c| c.empty? }).each do |oid|
      @schedules << @user.schedules.new do |s|
        s.user_id = @user.id
        s.offering_id = oid
      end
    end
    @current_schedules = @user.schedules.collect { |sched| sched.offering_id }

    @errors = []
    @schedules.each do |c|
      @sch = Schedule.find_or_create_by(user_id: c.user_id, offering_id: c.offering_id)
      if not @sch.errors.blank?
        @errors << @sch
      end
      @current_schedules -= [c.offering_id]
    end

    @current_schedules.each do |c|
      Schedule.where(user_id: @user.id, offering_id: c).take.destroy
    end
    @user_schedules = Schedule.where(user_id: @user.id)
    @day_hash2 = create_day_hash(@user_schedules.collect{ |course| Offering.find(course.offering_id) })
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:user_id, :schedule => [:offering_id])
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
    
    def sched_algorithm(uid) 
      @schedule = Schedule.new
      @category_courses = Hash.new
      @common_courses = Hash.new
      @category_credits = Hash.new
      @class_hash = Hash.new
      
      @categories = CurriculumCategory.where(major: User.find(uid).major_id).collect { |cat| cat.id }
      @user_courses = Transcript.where(user_id: uid).collect { |c| c.course_id }
      
      @categories.each do |id|
        @category_courses[id] = CurriculumCategoryCourse.where(curriculum_category_id: id).collect { |course| course.course_id }
        @common_courses[id] = @category_courses[id] & @user_courses
      end
      
      @common_courses.each do |key, val|
        @category_credits[key] = (val.collect { |c| Course.find(c).credits }).inject(:+)
      end
      
      @remaining_credits = @category_credits.clone
  
      @remaining_credits.each do |k, v|
        if v != nil
          @remaining_credits[k] = CurriculumCategory.find(k).required_amount_of_credits - v
        else
          @remaining_credits[k] = CurriculumCategory.find(k).required_amount_of_credits
        end
      end
      
      @categories.each do |id|
        if @category_credits[id] and ((@category_credits[id] - CurriculumCategory.find(id).required_amount_of_credits) >= 0)
          @category_credits.delete(id)
        end
        @common_courses[id] = (@common_courses[id].collect { |c_id| Course.find(c_id) }).sort! { |a,b| b.course <=> a.course }
      end
      
      @categories_left = @category_credits.keys    
      
      Course.all.each do |course|
        prereq_s = Set.new
      
        course.courses.each do |prereq|
          prereq_s.add(prereq.id)
        end
        
        @class_hash[course.id] = prereq_s
      end
      
      Transcript.where(user_id: uid).find_each do |c|
        @class_hash.delete(c.course_id)
        
        keys = @class_hash.keys
        keys.each do |key|
          @class_hash[key] = (@class_hash[key].to_a - [c.course_id]).to_set
        end
      end
  
      @sorted = toposort(@class_hash)[0]
      
      @new_category_courses = Hash.new
      @categories.each do |cat|
        if @categories_left.include? cat
          @new_category_courses[cat] = @category_courses[cat] & @sorted
        end
      end
      
      @new_category_courses.each do |k, v|
        x = []
        v.each do |id|
          Offering.where(course_id: id).find_each do |offering|
           x << offering
          end
        end
        @new_category_courses[k] = x
      end
      @schedules = @user.schedules.collect { |course| Offering.find(course.offering_id) }
      
      return @schedules, @common_courses, @new_category_courses, @remaining_credits
    end
    
    def create_day_hash(offerings)
      day_hash = {"Monday" => [],
                 "Tuesday"=> [],
                 "Wednesday"=> [],
                 "Thursday"=> [],
                 "Friday"=> []
                }
      offerings.each do |course|
        if course.days_time.days.include? "M"
          day_hash["Monday"] << course
        end
        if course.days_time.days.include? "T"
          day_hash["Tuesday"] << course
        end
        if course.days_time.days.include? "W"
          day_hash["Wednesday"] << course
        end
        if course.days_time.days.include? "R"
          day_hash["Thursday"] << course
        end
        if course.days_time.days.include? "F"
          day_hash["Friday"] << course
        end
      end
      return day_hash
    end
end
