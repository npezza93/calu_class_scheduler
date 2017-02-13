# frozen_string_literal: true
class AddSectionToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :section, :string
  end
end
