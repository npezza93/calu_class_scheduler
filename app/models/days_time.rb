class DaysTime < ActiveRecord::Base
  validates_uniqueness_of :days, scope: [:start_time, :end_time]
end
