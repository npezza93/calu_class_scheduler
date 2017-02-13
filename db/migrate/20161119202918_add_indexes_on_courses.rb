# frozen_string_literal: true
class AddIndexesOnCourses < ActiveRecord::Migration[5.0]
  def change
    add_index :courses, :subject
    add_index :courses, :course
  end
end
