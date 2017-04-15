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
  validates :semester, uniqueness: true, presence: true

  def self.active(date = Date.current)
    where(arel_table[:start_on].lteq(date)).find_by(
      arel_table[:end_on].gteq(date)
    )
  end
end
