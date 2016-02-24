class RenameCourseGroupIdToPrerequisiteGroupIdInPrerequisites < ActiveRecord::Migration
  def change
    rename_column :prerequisites, :course_group_id, :prerequisite_group_id
  end
end
