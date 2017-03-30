# == Schema Information
#
# Table name: schedule_category_offerings
#
#  id          :integer          not null, primary key
#  offering_id :integer
#  category_id :integer
#  hidden      :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Schedule::CategoryOffering < ApplicationRecord
  belongs_to :offering
  belongs_to :category
end
