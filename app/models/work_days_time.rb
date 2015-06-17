class WorkDaysTime < ActiveRecord::Base
    validates_uniqueness_of :days, scope: [:start_time, :end_time]

    def short_time
    	self.days + self.start_time.strftime("%l%M%p").strip
    end
end
