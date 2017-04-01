# frozen_string_literal: true

module SemesterHelpers
  extend ActiveSupport::Concern

  included do
    belongs_to :semester

    scope :for_semester, ->(semester) { where(semester: semester) }
  end
end
