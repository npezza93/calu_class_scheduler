class WorkSchedule < ApplicationRecord
  belongs_to :user
  belongs_to :work_days_time
  belongs_to :semester

  validates_uniqueness_of :work_days_time, scope: :user

  def pretty_day_time
    work_days_time.short_time
  end

  def prettier_day_time
    work_days_time.days + work_days_time.start_time.strftime('%l:%M%p').strip
  end
end
