# frozen_string_literal: true
class CreatePrerequisites < ActiveRecord::Migration
  def change
    create_table :prerequisites do |t|
      t.integer :parent_course_id
      t.integer :prerequisite_course_id

      t.timestamps
    end
  end
end