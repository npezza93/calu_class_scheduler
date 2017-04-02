# frozen_string_literal: true

class RemoveCourseGroupIdFromCurriculumCategorySets < ActiveRecord::Migration
  def change
    remove_column :curriculum_category_sets, :course_group_id, :integer
  end
end
