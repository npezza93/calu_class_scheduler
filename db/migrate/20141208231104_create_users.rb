# frozen_string_literal: true
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.boolean :administrator, default: false
      t.boolean :advisor, default: false

      t.timestamps
    end
  end
end
