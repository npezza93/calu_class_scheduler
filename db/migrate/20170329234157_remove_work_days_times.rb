# frozen_string_literal: true

class RemoveWorkDaysTimes < ActiveRecord::Migration[5.1]
  def up
    WorkSchedule.reset_column_information

    update_work_schedules
    drop_table :work_days_times
    remove_reference :work_schedules, :work_days_time
  end

  def down
    create_table :work_days_times
    add_reference :work_schedules, :work_days_time
  end

  private

  def update_work_schedules
    WorkSchedule.find_each do |work_schedule|
      work_days_time = work_days_times[work_schedule.work_days_time_id]
      work_schedule.update(
        day: work_days_time.first["days"],
        start_time: Time.parse(
          "2001-01-01 #{work_days_time.first['start_time']} utc"
        )
      )
    end
  end

  def work_days_times
    @work_days_times ||= ActiveRecord::Base.connection.execute(
      "SELECT * FROM work_days_times"
    ).to_a.group_by { |wdt| wdt["id"] }
  end
end
