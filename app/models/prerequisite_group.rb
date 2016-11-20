class PrerequisiteGroup < ApplicationRecord
  has_many :prerequisites
  has_many :courses, through: :prerequisites
  belongs_to :course

  accepts_nested_attributes_for :prerequisites, reject_if: :all_blank,
                                                allow_destroy: true
end
