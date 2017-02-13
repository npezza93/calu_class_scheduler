# frozen_string_literal: true
class AddLastNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
  end
end
