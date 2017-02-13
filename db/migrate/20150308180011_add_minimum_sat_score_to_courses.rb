# frozen_string_literal: true
class AddMinimumSatScoreToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :minimum_sat_score, :string
  end
end
