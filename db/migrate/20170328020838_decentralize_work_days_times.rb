class DecentralizeWorkDaysTimes < ActiveRecord::Migration[5.1]
  def up
    WorkSchedule.reset_column_information

    WorkSchedule.find_each do |work_schedule|
      days_time = work_schedule.work_days_time

      work_schedule.update(
        day: days_time.days,
        start_time: days_time.start_time,
      )
    end
  end

  def down
  end
end
