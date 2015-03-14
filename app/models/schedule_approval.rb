class ScheduleApproval < ActiveRecord::Base
    belongs_to :user
    belongs_to :semester
    before_save :set_default_semester
    
    validates_uniqueness_of :user, scope: [:semester]

    private
      def set_default_semester
        self.semester = Semester.where(active: true).take
      end
end