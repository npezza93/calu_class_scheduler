# frozen_string_literal: true

# == Schema Information
#
# Table name: prerequisite_groups
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PrerequisiteGroup < ApplicationRecord
  has_many :prerequisites
  has_many :courses, through: :prerequisites
  belongs_to :course

  accepts_nested_attributes_for :prerequisites, reject_if: :all_blank,
                                                allow_destroy: true
end
