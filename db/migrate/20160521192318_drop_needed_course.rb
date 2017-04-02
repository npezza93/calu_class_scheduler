# frozen_string_literal: true

class DropNeededCourse < ActiveRecord::Migration[5.0]
  def change
    drop_table :needed_courses
  end
end
