class CurriculumCategorySet < ActiveRecord::Base
  belongs_to :curriculum_category
  has_many :course_sets
  has_many :courses, through: :course_sets

  validates :count, numericality: { only_integer: true }, allow_blank: true

  accepts_nested_attributes_for :course_sets,
                                reject_if: :all_blank, allow_destroy: true
end
