# frozen_string_literal: true
class CreateCurriculumCategoryCourses < ActiveRecord::Migration
  def change
    create_table :curriculum_category_courses do |t|
      t.belongs_to :curriculum_category, index: true
      t.belongs_to :course, index: true

      t.timestamps
    end
  end
end
