# frozen_string_literal: true

class AddValuesToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :values, :boolean, default: false
  end
end
