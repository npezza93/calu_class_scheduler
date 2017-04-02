# frozen_string_literal: true

class AddCreditsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :credits, :integer, default: 3
  end
end
