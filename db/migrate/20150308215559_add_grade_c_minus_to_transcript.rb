# frozen_string_literal: true
class AddGradeCMinusToTranscript < ActiveRecord::Migration
  def change
    add_column :transcripts, :grade_c_minus, :boolean
  end
end
