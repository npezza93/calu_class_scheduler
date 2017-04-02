# frozen_string_literal: true

class RemoveElective1AndElective2AndCoreAndBuildingASenseOfCommunityAndCriticalThinkingSkillsAndValuesAndTechnologicalLiteracyAndMathematicsAndCommunicationSkillsFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :elective1, :boolean
    remove_column :courses, :elective2, :boolean
    remove_column :courses, :core, :boolean
    remove_column :courses, :building_a_sense_of_community, :boolean
    remove_column :courses, :critical_thinking_skills, :boolean
    remove_column :courses, :values, :boolean
    remove_column :courses, :technological_literacy, :boolean
    remove_column :courses, :mathematics, :boolean
    remove_column :courses, :communication_skills, :boolean
  end
end
