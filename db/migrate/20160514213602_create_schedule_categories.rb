# frozen_string_literal: true
class CreateScheduleCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :schedule_categories do |t|
      t.belongs_to :user
      t.belongs_to :curriculum_category
      t.belongs_to :semester
      t.boolean    :completed

      t.timestamps
    end
  end
end
