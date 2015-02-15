module ApplicationHelper
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
          
      
      work_schedules = WorkSchedule.where(user_id: uid, semester: Semester.where(active: true).take)
      @new_category_courses.each do |k, v|
        x = []
        y = []

        v.each do |id|
          Offering.where(course_id: id, semester: Semester.where(active: true).take).each do |offering|
           work_schedules.each do |work|
            if offering.days_time.days.include?(work.work_days_time.days)
              start_time = Time.parse(offering.days_time.start_time + "00-01-01")
              end_time  = Time.parse(offering.days_time.end_time + "00-01-01")

              if (start_time <= work.work_days_time.end_time and work.work_days_time.start_time <=end_time) 
              	x << offering
              end
            end
          end
          y << offering
          end
        end
        @new_category_courses[k] = y.uniq - x.uniq
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
