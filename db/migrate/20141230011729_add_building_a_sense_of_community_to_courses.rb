# frozen_string_literal: true

class AddBuildingASenseOfCommunityToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :building_a_sense_of_community, :boolean, default: false
  end
end
