class PrerequisiteGroup < ActiveRecord::Base
  has_many :prerequisites
  belongs_to :course

  accepts_nested_attributes_for :prerequisites,
                                reject_if: :all_blank, allow_destroy: true
end
