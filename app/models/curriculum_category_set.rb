# frozen_string_literal: true

# == Schema Information
#
# Table name: curriculum_category_sets
#
#  id                     :integer          not null, primary key
#  curriculum_category_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#  count                  :integer
#

class CurriculumCategorySet < ApplicationRecord
  belongs_to :curriculum_category
  has_many :course_sets
  has_many :courses, through: :course_sets

  validates :count, numericality: { only_integer: true }, allow_blank: true

  def pretty_count
    if count.blank?
      "All courses are required"
    else
      "Choose #{count.to_words} of the following"
    end
  end
end
