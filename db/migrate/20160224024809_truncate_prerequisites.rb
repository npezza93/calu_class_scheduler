# frozen_string_literal: true
class TruncatePrerequisites < ActiveRecord::Migration[4.2]
  def change
    ActiveRecord::Base.connection.execute("TRUNCATE prerequisites")
  end
end
