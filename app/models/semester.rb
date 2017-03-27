# frozen_string_literal: true

# == Schema Information
#
# Table name: semesters
#
#  id         :integer          not null, primary key
#  semester   :string(255)
#  active     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Semester < ApplicationRecord
  default_scope { order(:semester) }

  validates :semester, uniqueness: true, presence: true

  def self.active
    find_by(active: true)
  end
end
