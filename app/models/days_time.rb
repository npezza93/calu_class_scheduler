class DaysTime < ActiveRecord::Base
  validates_uniqueness_of :days, scope: [:start_time, :end_time]

  def pretty_day_time
	(self.days == "ONLINE" or self.days == "OFFSITE") ? self.days : self.days + ' at ' + self.start_time + ' to ' + self.end_time
  end
end
