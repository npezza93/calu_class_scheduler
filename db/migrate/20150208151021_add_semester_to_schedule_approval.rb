# frozen_string_literal: true

class AddSemesterToScheduleApproval < ActiveRecord::Migration
  def change
    add_reference :schedule_approvals, :semester, index: true
  end
end
