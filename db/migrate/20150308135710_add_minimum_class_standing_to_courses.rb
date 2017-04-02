# frozen_string_literal: true

class AddMinimumClassStandingToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :minimum_class_standing, :string
  end
end
