# frozen_string_literal: true
class AddTechnologicalLiteracyToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :technological_literacy, :boolean, default: false
  end
end
