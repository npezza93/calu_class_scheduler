# frozen_string_literal: true

class AddSemesterToOffering < ActiveRecord::Migration
  def change
    add_reference :offerings, :semester, index: true
  end
end
