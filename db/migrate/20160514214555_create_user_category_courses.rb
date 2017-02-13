# frozen_string_literal: true
class CreateUserCategoryCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_category_courses do |t|
      t.belongs_to :user_category, foreign_key: true
      t.belongs_to :course, foreign_key: true

      t.timestamps
    end
  end
end
