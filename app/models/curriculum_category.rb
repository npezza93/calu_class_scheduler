class CurriculumCategory < ActiveRecord::Base
  belongs_to :major
  validates :category, presence: true

  validates_uniqueness_of :category, scope: [:major, :minor]
  has_many :curriculum_category_sets
end
