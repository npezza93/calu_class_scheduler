# frozen_string_literal: true

class AddPtAPtBPtCPtDToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pt_a, :integer
    add_column :users, :pt_b, :integer
    add_column :users, :pt_c, :integer
    add_column :users, :pt_d, :integer
  end
end
