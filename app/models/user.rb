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
#  guest                  :boolean
#

class User < ApplicationRecord
  attr_accessor :reset

  devise :database_authenticatable, :registerable, :recoverable, :trackable,
         :validatable

  validates :first_name, :last_name, presence: true
  validates :major, presence: true
  validates :advised_by, presence: true, if: :student?
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }

  belongs_to :major
  belongs_to :advisor_prof, class_name: "User", foreign_key: :advised_by
  has_many   :schedule_approvals, dependent: :destroy
  has_many   :transcripts
  has_many   :taken_courses, through: :transcripts, source: :course
  has_many   :schedules, dependent: :destroy
  has_many   :offerings, through: :schedules
  has_many   :offering_day_times, through: :offerings, source: :days_time
  has_many   :courses, through: :offerings
  has_many   :work_schedules, dependent: :destroy

  has_many   :schedules_categories, class_name: "Schedules::Category",
                                    dependent: :destroy
  has_many   :schedules_offerings, through: :schedules_categories,
                                   source: :category_offerings,
                                   class_name: "Schedules::CategoryOffering"

  scope :offering_advisors, lambda {
    where(advisor: true).or(where(email: "staff@calu.edu"))
  }

  serialize :minor, Array

  before_validation do |model|
    model.minor&.reject!(&:blank?)
  end

  after_update :check_schedule_reset

  def student?
    !advisor? && !guest?
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
    User.includes(:schedules, :schedule_approvals).where(advised_by: self)
  end

  def credits(semester)
    schedules.select do |schedule|
      schedule.semester_id == semester
    end.sum { |schedule| schedule.course.credits }
  end

  def categories
    @categories ||= categories_query.includes(
      curriculum_category_sets: { courses: [
        :prerequisites, :offerings, prerequisite_groups: :prerequisites
      ] }
    )
  end

  def categories_for_courses(course_ids)
    categories.where(
      id: categories_query.joins(:courses).where(courses: { id: course_ids })
    )
  end

  def plain_categories_for_courses(course_ids)
    categories_query.where(
      id: categories_query.joins(:courses).where(courses: { id: course_ids })
    )
  end

  def after_database_authentication
    return if schedules_categories.for_semester(Semester.active).exists?

    Scheduler::Runner.new(user: self, semester: Semester.active).perform
  end

  def check_schedule_reset
    return if advisor?

    @reset = major_id_changed? || minor_changed? || class_standing_changed? ||
      sat_score_changed? || pt_changed?
  end

  private

  def categories_query
    CurriculumCategory.where(major_id: major_id, minor: false).or(
      CurriculumCategory.where(major_id: minor, minor: true)
    )
  end

  def sat_score_changed?
    sat_520_changed? || sat_580_changed? || sat_440_changed? ||
      sat_640_changed? || sat_700_changed?
  end

  def pt_changed?
    pt_a_changed? || pt_b_changed? || pt_c_changed? || pt_d_changed?
  end
end
