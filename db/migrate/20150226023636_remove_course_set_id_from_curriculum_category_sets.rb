# frozen_string_literal: true
class RemoveCourseSetIdFromCurriculumCategorySets < ActiveRecord::Migration
  def change
    remove_column :curriculum_category_sets, :course_set_id, :integer
  end
end
