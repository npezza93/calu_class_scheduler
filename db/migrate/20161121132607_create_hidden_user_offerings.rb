# frozen_string_literal: true
class CreateHiddenUserOfferings < ActiveRecord::Migration[5.0]
  def change
    create_table :hidden_user_offerings do |t|
      t.text :offerings
      t.belongs_to :user, foreign_key: true
      t.belongs_to :semester, foreign_key: true

      t.timestamps
    end
  end
end
