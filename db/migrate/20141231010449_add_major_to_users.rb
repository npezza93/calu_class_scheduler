# frozen_string_literal: true

class AddMajorToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :major, index: true
  end
end
