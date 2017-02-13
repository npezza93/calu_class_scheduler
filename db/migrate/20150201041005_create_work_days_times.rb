# frozen_string_literal: true
class CreateWorkDaysTimes < ActiveRecord::Migration
  def change
    create_table :work_days_times do |t|
      t.string :days
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
