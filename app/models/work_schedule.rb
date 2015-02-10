class WorkSchedule < ActiveRecord::Base
  belongs_to :user
  belongs_to :work_days_time
  belongs_to :semester
  
  before_save :default_semester
  
  validates_uniqueness_of :work_days_time, scope: :user
  
  private
    def default_semester
      self.semester = Semester.where(active: true).take
    end
end
