class CreditValidator < ActiveModel::Validator
  def validate(schedule)
    user = schedule.user_id

    credits = 0
    Schedule.where(user_id: user, semester: schedule.semester).find_each { |s| credits += s.offering.course.credits }

    if (credits+schedule.offering.course.credits) > 18
      schedule.errors[:Credits] << 'cannot exceed the maximum of 18'
    end
  end
end

class ClassOverlapValidator < ActiveModel::Validator
  def validate(schedule)
    user = schedule.user_id
    
    begin
      start_time_in_q = Time.new(2000,1,1,schedule.offering.days_time.start_time.split(":")[0],schedule.offering.days_time.start_time.split(":")[1]) 
      end_time_in_q = Time.new(2000,1,1,schedule.offering.days_time.end_time.split(":")[0],schedule.offering.days_time.end_time.split(":")[1]) 
  
      days_in_q = schedule.offering.days_time.days
      
      if schedule.offering.days_time.start_time.split(" ")[1] == "pm"
        start_time_in_q += 12.hours
      end
      
      if schedule.offering.days_time.end_time.split(" ")[1] == "pm"
        end_time_in_q += 12.hours
      end
  
      day_time_ar = Schedule.where(user_id: user, semester: schedule.semester).find_each.collect { |s| [s.offering.days_time.days, s.offering.days_time.start_time, s.offering.days_time.end_time] }
    
      day_time_ar.each do |off_time|
        start_off_time = Time.new(2000,1,1,off_time[1].split(":")[0], off_time[1].split(":")[1])
        end_off_time = Time.new(2000,1,1,off_time[2].split(":")[0], off_time[2].split(":")[1]) 
  
        if off_time[1].split(" ")[1] == "pm"
          start_off_time += 12.hours
        end
        
        if off_time[1].split(" ")[1] == "pm"
          end_off_time += 12.hours
        end
        
        if days_in_q == off_time[0]
          if (start_time_in_q <= end_off_time and start_off_time <=end_time_in_q) 
            schedule.errors[:Course_times] << 'cannot overlap'
          end
        end
      end
    rescue
    end
  end
end

class CourseOverlapValidator < ActiveModel::Validator
  def validate(schedule)
    user = schedule.user_id
    
    course_in_q = schedule.offering.course.id
    
    course_ar = Schedule.where(user_id: user, semester: schedule.semester).find_each.collect { |s| s.offering.course.id }
  
    course_ar.each do |course|

      if course == course_in_q
          schedule.errors[:Already_enrolled] << 'in course'
      end
    end
  end
end

class Schedule < ActiveRecord::Base
  belongs_to :offering
  belongs_to :user
  belongs_to :semester
  
  before_save :set_default_semester
  before_validation :set_default_semester
  
  validates_uniqueness_of :offering, scope: :user
  validates_with CreditValidator
  validates_with ClassOverlapValidator
  validates_with CourseOverlapValidator
  
  private
    def set_default_semester
      self.semester = Semester.where(active: true).take
    end
end