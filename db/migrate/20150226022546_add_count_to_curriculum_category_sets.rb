# frozen_string_literal: true

class AddCountToCurriculumCategorySets < ActiveRecord::Migration
  def change
    add_column :curriculum_category_sets, :count, :integer
  end
end
