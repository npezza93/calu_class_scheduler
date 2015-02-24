class AddCourseGroupIdToCurriculumCategoryCourses < ActiveRecord::Migration
  def change
    add_column :curriculum_category_courses, :course_group_id, :integer
  end
end
