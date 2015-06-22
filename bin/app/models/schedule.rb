class CreditNCourseValidator < ActiveModel::Validator
  def validate(schedule)
    user_id = schedule.user_id
    user = User.includes(:courses).find(112)

    credits = 0
    user.courses.each { |course| credits += course.credits }

    if (credits+schedule.course.credits) > 18
      schedule.errors[:Credits] << 'cannot exceed the maximum of 18'
    end

    begin
      schedule_days_time = schedule.offering.days_time
      start_time_in_q = Time.parse(schedule_days_time.start_time) 
      end_time_in_q = Time.parse(schedule_days_time.end_time) 
  
      days_in_q = schedule_days_time.days
      
      day_time_ar = schedule.user.offerings.includes(:days_time).collect { |s| [s.days_time.days, Time.parse(s.days_time.start_time), Time.parse(s.days_time.end_time)] }
    
      day_time_ar.each do |off_time|
        if (days_in_q == off_time[0]) and (start_time_in_q <= end_off_time and start_off_time <=end_time_in_q) 
          schedule.errors[:Course_times] << 'cannot overlap'
        end
      end
    rescue
    end
    
    if user.courses.collect(&:id).include?(schedule.course.id)
      schedule.errors[:Already_enrolled] << 'in course'
    end
  end
end

class Schedule < ActiveRecord::Base
  belongs_to :offering
  belongs_to :user
  belongs_to :semester
  
  has_one :course, through: :offering
  
  before_save :set_default_semester
  before_validation :set_default_semester
  
  validates_uniqueness_of :offering, scope: :user
  validates_with CreditNCourseValidator

  private
    def set_default_semester
      self.semester = Semester.where(active: true).take
    end
end