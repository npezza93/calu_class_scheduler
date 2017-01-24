# frozen_string_literal: true
class Semester < ApplicationRecord
  default_scope { order(:semester) }

  validates :semester, uniqueness: true, presence: true

  def self.active
    find_by(active: true)
  end
end
