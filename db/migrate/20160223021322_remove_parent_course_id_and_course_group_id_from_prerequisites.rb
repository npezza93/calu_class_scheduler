# frozen_string_literal: true
class RemoveParentCourseIdAndCourseGroupIdFromPrerequisites < ActiveRecord::Migration
  def change
    remove_column :prerequisites, :prerequisite_course_id, :integer
  end
end
