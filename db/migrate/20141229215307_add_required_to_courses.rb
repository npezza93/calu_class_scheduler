# frozen_string_literal: true

class AddRequiredToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :required, :boolean, default: false
  end
end
