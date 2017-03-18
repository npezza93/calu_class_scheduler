# frozen_string_literal: true
# == Schema Information
#
# Table name: hidden_user_offerings
#
#  id          :integer          not null, primary key
#  offerings   :text
#  user_id     :integer
#  semester_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class HiddenUserOffering < ApplicationRecord
  belongs_to :user
  belongs_to :semester

  serialize :offerings, Array
end
