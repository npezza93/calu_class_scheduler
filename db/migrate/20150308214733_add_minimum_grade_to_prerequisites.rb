# frozen_string_literal: true
class AddMinimumGradeToPrerequisites < ActiveRecord::Migration
  def change
    add_column :prerequisites, :minimum_grade, :string
  end
end
