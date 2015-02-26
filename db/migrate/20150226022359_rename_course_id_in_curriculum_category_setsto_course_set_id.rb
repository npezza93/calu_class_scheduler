class RenameCourseIdInCurriculumCategorySetstoCourseSetId < ActiveRecord::Migration
  def change
    rename_column :curriculum_category_sets, :course_id, :course_set_id
  end
end
