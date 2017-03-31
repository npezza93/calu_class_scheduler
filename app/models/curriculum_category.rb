# frozen_string_literal: true

# == Schema Information
#
# Table name: curriculum_categories
#
#  id              :integer          not null, primary key
#  category        :string(255)
#  major_id        :integer
#  created_at      :datetime
#  updated_at      :datetime
#  minor           :boolean
#  set_and_or_flag :string
#

class CurriculumCategory < ApplicationRecord
  belongs_to :major
  has_many :curriculum_category_sets, dependent: :destroy
  has_many :course_sets, through: :curriculum_category_sets, dependent: :destroy
  has_many :courses, through: :course_sets
  has_many :offerings, through: :courses

  validates :category, presence: true
  validates :minor, inclusion: { in: [true, false] }
  validates :category, uniqueness: { scope: %i(major minor) }

  accepts_nested_attributes_for :curriculum_category_sets, allow_destroy: true,
                                                           reject_if: :all_blank

  scope :major, ->(major_id) { where(major_id: major_id, minor: false) }

  def pretty_set_flag
    if or_sets?
      "One of the following sections has to be completed"
    else
      "All the sections have to be completed"
    end
  end

  def scheduler_minor_display
    " - #{major.major} Minor" if minor
  end

  def display
    "#{category}#{scheduler_minor_display}"
  end

  def complete?(sets)
    if or_sets?
      sets.compact.inject(:|)
    else
      sets.compact.inject(:&)
    end
  end

  def or_sets?
    set_and_or_flag == "true"
  end
end
