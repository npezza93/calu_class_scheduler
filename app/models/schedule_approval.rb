class ScheduleApproval < ActiveRecord::Base
    belongs_to :user
    belongs_to :semester
    before_save :set_default_semester
    
    validates :user, uniqueness: true

    private
      def set_default_semester
        self.semester = Semester.where(active: true).take
      end
end