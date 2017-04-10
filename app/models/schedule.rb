# frozen_string_literal: true

# == Schema Information
#
# Table name: schedules
#
#  id          :integer          not null, primary key
#  offering_id :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  semester_id :integer
#

class Schedule < ApplicationRecord
  include SemesterHelpers

  belongs_to :offering
  belongs_to :user

  has_one :course, through: :offering
  has_one :days_time, through: :offering

  validates :offering, uniqueness: { scope: %i(user_id semester_id) }
  validate do
    errors.add(:base, "You cannot take more than 18 credits") if
      user.credits(semester_id) > 18
  end
  validate do
    errors.add(:base, "You've already scheduled for that course") if
      user.courses.where(
        offerings: { course_id: offering.course_id },
        schedules: { semester_id: semester_id }
      ).exists?
  end
end
