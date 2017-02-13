# frozen_string_literal: true
class AddGradeToTranscripts < ActiveRecord::Migration
  def change
    add_column :transcripts, :grade, :string, default: "NG"
  end
end
