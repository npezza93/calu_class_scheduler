# frozen_string_literal: true

class RemoveAdministratorFrom < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :administrator, :boolean
  end
end
