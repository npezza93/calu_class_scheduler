class User < ApplicationRecord
  include Scheduler
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
  validates :major, presence: true
  validates :advised_by, presence: true, if: '!advisor'
  validates :email, uniqueness: true
  validates :email,
            format: {
              with: /@calu.edu\Z/, message: 'must be a CalU email address'
            }

  belongs_to :major
  has_many :transcripts
  has_many :taken_courses, through: :transcripts, source: :course
  has_many :schedules, -> { where(semester: Semester.active) }
  has_many :offerings, through: :schedules
  has_many :offering_day_times, through: :offerings, source: :days_time
  has_many :courses, through: :offerings
  has_many :work_schedules, -> { where(semester: Semester.active) }
  has_many :work_days_times, through: :work_schedules
  has_many :user_categories
  has_many :available_offerings, ->{ where('user_category_courses.completed = ?', false) }, class_name: 'Offering', through: :user_categories, source: :offerings

  scope :offering_advisors, lambda {
    where('advisor = ? OR email = ?', true, 'staff@calu.edu')
  }
  serialize :minor, Array

  before_validation do |model|
    model.minor.reject!(&:blank?) if model.minor
  end

  def name
    first_name + ' ' + last_name
  end

  def current_credits
    courses.sum(&:credits)
  end

  def send_for_approval
    UserMailer.submit_for_advising(self).deliver
  end

  def send_approval_submission_confirmation
    UserMailer.approval_submission_confirmation(self).deliver
  end

  def send_approved_confirmation
    UserMailer.approval_confirmation(self).deliver
  end

  def send_approved
    UserMailer.approved(self).deliver
  end

  def advisees
    User.includes(:courses).where(advised_by: self)
  end

  def students
    User.includes(:courses).where(advisor: false, administrator: false)
        .where.not(advised_by: self)
  end

  def self.search(user, search = nil)
    if search.blank?
      user.advisees + user.students
    else
      where('first_name LIKE ?
             OR last_name LIKE ?
             OR email LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
        .where(advisor: false, administrator: false)
    end
  end

  def self.sort_options
    ['All Students', 'My Advisees']
  end

  def offerings_that_overlap
    available = available_offerings.includes(:days_time)
    taking = offerings.includes(:days_time)
    available -= taking

    taking = taking.collect(&:days_time)
    taking.concat(work_days_times)

    offering_ids = available.select do |offering|
      offering.days_time.overlaps_any? taking
    end

    offering_ids.pluck(:id)
  end
end
