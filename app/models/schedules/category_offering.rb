# frozen_string_literal: true

# == Schema Information
#
# Table name: schedules_category_offerings
#
#  id          :integer          not null, primary key
#  offering_id :integer
#  category_id :integer
#  hidden      :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module Schedules
  class CategoryOffering < ApplicationRecord
    default_scope { order(:offering_id) }

    belongs_to :offering
    belongs_to :category
    delegate :course, to: :offering

    scope :visible, -> { where(hidden: false) }
    scope :hidden,  -> { where(hidden: true)  }

    def self.table_name_prefix
      "schedules_"
    end
  end
end
