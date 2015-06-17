class WrkScheduleAdvisorChk < ActiveModel::Validator
  def validate(wrkschedule)
    
    user = wrkschedule.user_id
    if User.find(user).advisor
      wrkschedule.errors[:Advisors] << 'cannot add work schedule times'
    end
  end
end

class WorkSchedule < ActiveRecord::Base
  belongs_to :user
  belongs_to :work_days_time
  belongs_to :semester
  
  validates_with WrkScheduleAdvisorChk
  before_save :default_semester
  
  validates_uniqueness_of :work_days_time, scope: :user
  
  def pretty_day_time
    self.work_days_time.short_time
  end

  def prettier_day_time
    self.work_days_time.days + self.work_days_time.start_time.strftime("%l:%M%p").strip
  end

  private
    def default_semester
      self.semester = Semester.where(active: true).take
    end
end
