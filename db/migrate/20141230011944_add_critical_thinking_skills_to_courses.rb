class AddCriticalThinkingSkillsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :critical_thinking_skills, :boolean, default: false
  end
end
