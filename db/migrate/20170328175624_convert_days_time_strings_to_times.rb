# frozen_string_literal: true

class ConvertDaysTimeStringsToTimes < ActiveRecord::Migration[5.1]
  def up
    days_time_hash

    change_column :days_times, :start_time, :datetime, using: "date '2000-01-01'"
    change_column :days_times, :end_time, :datetime, using: "date '2000-01-01'"

    DaysTime.reset_column_information
    DaysTime.find_each do |day_time|
      day_time.update(
        start_time: days_time_hash[day_time.id][:start_time],
        end_time: days_time_hash[day_time.id][:end_time]
      )
    end
  end

  def down
    change_column :days_times, :start_time, :string
    change_column :days_times, :end_time, :string
  end

  private

  def days_time_hash
    @days_time_hash ||= DaysTime.all.group_by(&:id).transform_values do |values|
      {
        start_time: Time.parse("2000-01-01 #{values.first.start_time} utc"),
        end_time: Time.parse("2000-01-01 #{values.first.end_time} utc")
      }
    end
  end
end
