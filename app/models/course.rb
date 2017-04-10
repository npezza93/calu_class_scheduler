# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id                     :integer          not null, primary key
#  subject                :string(255)
#  course                 :integer
#  title                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  credits                :integer          default(3)
#  minimum_class_standing :string(255)
#  minimum_sat_score      :string(255)
#  minimum_pt             :string(255)
#  description            :text
#

class Course < ApplicationRecord
  include UserDescriptorConstants

  has_many :prerequisite_groups, dependent: :destroy
  has_many :prerequisites, through: :prerequisite_groups, dependent: :destroy
  has_many :courses, through: :prerequisites
  has_many :offerings

  accepts_nested_attributes_for :prerequisite_groups,
                                allow_destroy: true, reject_if: :all_blank

  validates :title,   presence: true
  validates :subject, presence: true
  validates :course,  presence: true, numericality: { only_integer: true }
  validates :credits, presence: true, numericality: { only_integer: true }
  validates :course,  uniqueness: { scope: :subject }

  scope :subject_by_letter, lambda { |letter|
    select(:id, :subject, :course, :title).order(:subject, :course).where(
      arel_table[:subject].matches("#{letter || 'a'}%")
    )
  }
  scope :autocomplete_fields, lambda {
    order(:subject, :course).select(
      :id, :subject,
      "concat(courses.subject, courses.course, ': ', courses.title) AS title"
    )
  }

  def self.paginated_letters
    select(:subject).distinct.flat_map(&:subject).map(&:first).uniq.sort
  end

  def pretty_course
    condensed_course + ": " + title
  end

  def condensed_course
    subject + course.to_s
  end

  def prerequisite_info
    return "" if prerequisites.blank?

    if prerequisite_groups.size > 1
      prerequisite_groups.map do |prerequisite_group|
        prerequisite_group.courses.map(&:condensed_course).join(" and ")
      end.join(" or ")
    else
      courses.map(&:condensed_course).join(" and ")
    end
  end

  def prerequisites_fulfilled?(transcript, course_ids_taken)
    return true if prerequisite_groups.blank?

    prerequisite_groups.find do |prereq_group|
      prereq_group.prerequisites.all? do |prereq|
        prereq.passed?(transcript, course_ids_taken)
      end
    end
  end

  def can_take?(user, transcript, course_ids_taken)
    courses_to_take = failed_prerequisites(transcript, course_ids_taken)

    if prerequisites_fulfilled?(transcript, course_ids_taken) &&
        (passed_tests?(user) || passed_placement_test_or_sat?(user))
      courses_to_take << self
    end

    courses_to_take
  end

  def failed_prerequisites(transcript, course_ids_taken)
    prerequisites.map do |prerequisite|
      prerequisite.failed_course(transcript, course_ids_taken)
    end.compact
  end

  def passed_tests?(user)
    !minimum_pt? && eligible_class_standing?(user) && passed_sat?(user)
  end

  def eligible_class_standing?(user)
    return true unless minimum_class_standing?
    return false unless user.class_standing?

    YEAR[user.class_standing] <= YEAR[minimum_class_standing]
  end

  def passed_sat?(user)
    return true unless minimum_sat_score?

    user.send("sat_#{minimum_sat_score}")
  end

  def passed_placement_test_or_sat?(user)
    minimum_pt? && (passed_placement_test?(user) || passed_sat?(user))
  end

  def passed_placement_test?(user)
    if %w(A B C D-).include? minimum_pt
      user.send(user_pt_method) == 1
    elsif minimum_pt == "D"
      user.pt_d == 3
    else
      false
    end
  end

  def user_pt_method
    "pt_#{minimum_pt.tr('-', '').downcase}"
  end
end
