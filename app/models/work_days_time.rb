class WorkDaysTime < ActiveRecord::Base
  validates :days, uniqueness: { scope: [:start_time, :end_time] }

  def short_time
    days + start_time.strftime('%l%M%p').strip
  end
end
