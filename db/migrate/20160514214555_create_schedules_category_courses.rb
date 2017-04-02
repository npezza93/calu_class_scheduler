# frozen_string_literal: true

class CreateSchedulesCategoryCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules_category_courses do |t|
      t.belongs_to :category
      t.belongs_to :course

      t.timestamps
    end
  end
end
