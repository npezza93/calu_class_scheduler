# frozen_string_literal: true
class AddCurriculumCategorySetToCourseSet < ActiveRecord::Migration
  def change
    add_reference :course_sets, :curriculum_category_set, index: true
  end
end
