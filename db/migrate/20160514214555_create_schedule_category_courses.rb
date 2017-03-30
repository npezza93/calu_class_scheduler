# frozen_string_literal: true
class CreateScheduleCategoryCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :schedule_category_courses do |t|
      t.belongs_to :category
      t.belongs_to :course

      t.timestamps
    end
  end
end
