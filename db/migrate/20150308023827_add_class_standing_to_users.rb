# frozen_string_literal: true
class AddClassStandingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :class_standing, :string
  end
end
