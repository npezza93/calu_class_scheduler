class DaysTime < ActiveRecord::Base
  validates_uniqueness_of :days, scope: [:start_time, :end_time]

  def pretty_day_time
    if days == 'ONLINE' || days == 'OFFSITE'
      days
    else
      days + ' at ' + start_time + ' to ' + end_time
    end
  end
end
