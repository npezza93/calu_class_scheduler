# frozen_string_literal: true

class AddElective1ToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :elective1, :boolean, default: false
  end
end
