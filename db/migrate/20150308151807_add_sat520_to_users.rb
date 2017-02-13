# frozen_string_literal: true
class AddSat520ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sat_520, :boolean
  end
end
