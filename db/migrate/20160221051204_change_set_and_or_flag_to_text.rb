# frozen_string_literal: true
class ChangeSetAndOrFlagToText < ActiveRecord::Migration[4.2]
  def change
    change_column(:curriculum_categories, :set_and_or_flag, :string)
  end
end
