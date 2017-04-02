# frozen_string_literal: true

class AddElective2ToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :elective2, :boolean, default: false
  end
end
