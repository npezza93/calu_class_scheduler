class AddCourseGroupIdToPrerequisites < ActiveRecord::Migration
  def change
    add_column :prerequisites, :course_group_id, :integer
  end
end
