class WorkDaysTime < ActiveRecord::Base
  validates :days, uniqueness: { scope: [:start_time, :end_time] }

  def short_time
    days + start_time.strftime('%l%M%p').strip
  end

  def day_of_week
    { m: 0, t: 1, w: 2, r: 3, f: 4 }[days.downcase.to_sym]
  end
end
