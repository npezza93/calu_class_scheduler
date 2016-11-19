class Schedule < ApplicationRecord
  belongs_to :offering
  belongs_to :user
  belongs_to :semester

  has_one :course, through: :offering

  validates :offering, uniqueness: { scope: :user }

  validate do
    errors.add(:base, "You cannot take more than 18 credits") if
      (user.credits + course.credits) > 18
  end

  validate do
    errors.add(:base, "You've already scheduled for that course") if
      user.courses.include? offering.course
  end

  validate do
    errors.add(:base, "You've already scheduled a course for that time") if
      offering.days_time.overlaps_any?(user.offering_day_times)
  end
end
