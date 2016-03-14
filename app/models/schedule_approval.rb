class ScheduleApproval < ActiveRecord::Base
  belongs_to :user
  belongs_to :semester

  validates_uniqueness_of :user, scope: [:semester]
end
