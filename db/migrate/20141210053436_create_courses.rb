# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :subject
      t.integer :course
      t.string :title

      t.timestamps
    end
  end
end
