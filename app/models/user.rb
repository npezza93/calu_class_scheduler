# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  advisor                :boolean          default(FALSE)
#  created_at             :datetime
#  updated_at             :datetime
#  advised_by             :integer
#  major_id               :integer
#  minor                  :text
#  first_name             :string(255)
#  last_name              :string(255)
#  class_standing         :string(255)
#  sat_520                :boolean
#  sat_580                :boolean
#  sat_440                :boolean
#  pt_a                   :integer
#  pt_b                   :integer
#  pt_c                   :integer
#  pt_d                   :integer
#  sat_640                :boolean
#  sat_700                :boolean
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :trackable,
         :validatable

  validates :first_name, :last_name, presence: true
  validates :major, presence: true
  validates :advised_by, presence: true, if: :student
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }

  belongs_to :major
  belongs_to :advisor_prof, class_name: "User", foreign_key: :advised_by
  has_one :schedule_approval, -> { where(semester: Semester.active) }
  has_many :transcripts
  has_many :taken_courses, through: :transcripts, source: :course
  has_many :schedules, -> { where(semester: Semester.active) }
  has_many :offerings, through: :schedules
  has_many :offering_day_times, through: :offerings, source: :days_time
  has_many :courses, through: :offerings
  has_many :work_schedules, -> { where(semester: Semester.active) }
  has_many :work_days_times, through: :work_schedules
  has_many :user_categories
  has_many :available_offerings, lambda {
    where(user_category_courses: { completed: false })
  }, class_name: "Offering", through: :user_categories, source: :offerings
  has_many :hidden_user_offerings

  scope :offering_advisors, lambda {
    where(advisor: true).or(where(email: "staff@calu.edu"))
  }

  serialize :minor, Array

  before_validation do |model|
    model.minor&.reject!(&:blank?)
  end

  def student
    !advisor
  end

  def name
    first_name + " " + last_name
  end

  def professor
    if first_name.present?
      "#{first_name[0].capitalize}. "
    else
      ""
    end + last_name.capitalize
  end

  def advisees
    User.includes(:courses, :schedule_approval).where(advised_by: self)
  end

  def credits
    courses.sum(&:credits)
  end

  def categories
    @categories ||= CurriculumCategory.where(
      major_id: major_id, minor: false
    ).or(CurriculumCategory.where(major_id: minor, minor: true)).includes(
      :courses, curriculum_category_sets: {
        courses: { prerequisites: :course }
      }
    ).to_a
  end

  def offerings_that_overlap
    available = available_offerings.includes(:days_time)

    taking = offerings.includes(:days_time)
    taking_course_ids = offerings.pluck(:course_id)

    available -= taking
    taking = taking.collect(&:days_time) + work_days_times
    return [] if taking.empty?

    offering_ids = available.select do |offering|
      offering.days_time.overlaps_any?(taking) ||
        taking_course_ids.include?(offering.course_id)
    end

    offering_ids.pluck(:id)
  end
end
