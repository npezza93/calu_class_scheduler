# frozen_string_literal: true

class AddSemesterToSchedule < ActiveRecord::Migration
  def change
    add_reference :schedules, :semester, index: true
  end
end
