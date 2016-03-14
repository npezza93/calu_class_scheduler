class Schedule < ActiveRecord::Base
  belongs_to :offering
  belongs_to :user
  belongs_to :semester

  has_one :course, through: :offering

  validates :offering, uniqueness: { scope: :user }

  validate do
    errors.add(:base, 'You cannot take more than 18 credits') unless
      (user.current_credits + course.credits) > 18
  end

  validate do
    errors.add(:base, 'You\'ve already scheduled a course for that time') unless
      offering.days_time.overlaps_any?(user.offering_day_times)
  end
end
