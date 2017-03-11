# frozen_string_literal: true
class RenameCourseGroupIdToPrerequisiteGroupIdInPrerequisites < ActiveRecord::Migration[4.2]
  def change
    rename_column :prerequisites, :course_group_id, :prerequisite_group_id
    rename_column :prerequisites, :parent_course_id, :course_id
  end
end
