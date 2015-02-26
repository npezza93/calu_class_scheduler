class RenameCurriculumCategoryCourseToCurriculumCategorySet < ActiveRecord::Migration
  def change
    rename_table :curriculum_category_courses, :curriculum_category_sets
  end
end
