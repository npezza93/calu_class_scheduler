class WorkDaysTime < ActiveRecord::Base
  validates :days, uniqueness: { scope: [:start_time, :end_time] }
  scope :with_start_time, lambda { |sel|
    all.select { |day_time| day_time.parsed_start_time == sel }
  }

  def parsed_start_time
    start_time.strftime('%l:%M %P').strip
  end

  def short_time
    days + start_time.strftime('%l%M%p').strip
  end

  def day_of_week
    { m: 0, t: 1, w: 2, r: 3, f: 4 }[days.downcase.to_sym]
  end
end
