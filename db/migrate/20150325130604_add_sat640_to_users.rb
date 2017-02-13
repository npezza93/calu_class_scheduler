# frozen_string_literal: true
class AddSat640ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sat_640, :boolean
  end
end
