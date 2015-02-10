class CreditValidator12 < ActiveModel::Validator
  def validate(approval)
    user = approval.user
    credits = 0
    Schedule.where(user_id: user.id).find_each { |s| credits += s.offering.course.credits }

    if (credits) < 12
      schedule.errors[:Credits] << 'must exceed or be equal to 12'
    end
  end
end

class ScheduleApproval < ActiveRecord::Base
    belongs_to :user
    belongs_to :semester
    before_save :set_default_semester
    
    validates :user, uniqueness: true
    validates_with CreditValidator12
    
    private
      def set_default_semester
        self.semester = Semester.where(active: true).take
      end
end