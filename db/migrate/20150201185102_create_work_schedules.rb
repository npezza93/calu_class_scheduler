# frozen_string_literal: true
class CreateWorkSchedules < ActiveRecord::Migration
  def change
    create_table :work_schedules do |t|
      t.references :user, index: true
      t.references :work_days_time, index: true

      t.timestamps
    end
  end
end
