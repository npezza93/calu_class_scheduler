# frozen_string_literal: true

class AddInstructorToOfferings < ActiveRecord::Migration
  def change
    add_reference :offerings, :user, index: true
  end
end
