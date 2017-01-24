class Scheduler
  class AvailabilityUpdate
    attr_accessor :user, :time_block

    def initialize(user, time_block)
      @user       = user
      @time_block = time_block
    end

    def perform
      if time_block.is_a? DaysTime
        adjust_from_days_time
      else
        adjust_from_work_days_time
      end
    end

    def adjust_from_work_days_time
      days_times = DaysTime.where("days LIKE ?", "%#{time_block.days}%")
      overlap_ids = days_times.select do |day_time|
        day_time.overlaps? time_block
      end.map(&:id)

      user.hidden_user_offerings.new(offerings: categories(overlap_ids))
    end

    def categories(days_time_ids)
      @categories ||= user.user_categories.where(
        completed: false, offerings: { days_time_id: days_time_ids }
      ).includes(:offerings).joins(:offerings)
    end
  end
end
