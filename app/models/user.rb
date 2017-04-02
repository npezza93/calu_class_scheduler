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
  has_one    :schedule_approval
  has_many   :transcripts
  has_many   :taken_courses, through: :transcripts, source: :course
  has_many   :schedules
  has_many   :offerings, through: :schedules
  has_many   :offering_day_times, through: :offerings, source: :days_time
  has_many   :courses, through: :offerings
  has_many   :work_schedules

  has_many   :schedules_categories, class_name: "Schedules::Category"

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
    )
  end

  def categories_from_courses(course_ids)
    categories.where(course_sets: { course_id: course_ids })
  end
end
