# frozen_string_literal: true
class AddCommunicationSkillsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :communication_skills, :boolean, default: false
  end
end
