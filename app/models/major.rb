# frozen_string_literal: true

# == Schema Information
#
# Table name: majors
#
#  id         :integer          not null, primary key
#  major      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Major < ApplicationRecord
  validates :major, uniqueness: true, presence: true

  has_many :major_categories, -> { where minor: false },
           class_name: "CurriculumCategory"
  has_many :minor_categories, -> { where minor: true },
           class_name: "CurriculumCategory"
  has_many :categories, class_name: "CurriculumCategory"
end
