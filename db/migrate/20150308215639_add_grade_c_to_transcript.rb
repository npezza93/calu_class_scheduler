# frozen_string_literal: true

class AddGradeCToTranscript < ActiveRecord::Migration
  def change
    add_column :transcripts, :grade_c, :boolean
  end
end
