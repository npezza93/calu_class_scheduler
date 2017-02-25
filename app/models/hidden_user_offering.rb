# frozen_string_literal: true
class HiddenUserOffering < ApplicationRecord
  belongs_to :user
  belongs_to :semester

  serialize :offerings, Array
end