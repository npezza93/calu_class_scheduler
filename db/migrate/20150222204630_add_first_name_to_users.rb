# frozen_string_literal: true
class AddFirstNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
  end
end
