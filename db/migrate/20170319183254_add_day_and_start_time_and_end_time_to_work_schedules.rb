class AddDayAndStartTimeAndEndTimeToWorkSchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :work_schedules, :day, :string
    add_column :work_schedules, :start_time, :time
  end
end
