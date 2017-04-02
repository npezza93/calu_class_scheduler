# frozen_string_literal: true

class AddSemesterToWorkSchedule < ActiveRecord::Migration
  def change
    add_reference :work_schedules, :semester, index: true
  end
end
