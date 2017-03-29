# frozen_string_literal: true

# == Schema Information
#
# Table name: transcripts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  course_id     :integer
#  created_at    :datetime
#  updated_at    :datetime
#  grade_c_minus :boolean
#  grade_c       :boolean
#

class Transcript < ApplicationRecord
  GRADES = %w(A A- B+ B B- C+ C C- D+ D D- F).freeze

  belongs_to :user
  belongs_to :course

  validates :course, uniqueness: {
    scope: :user, message: "You've already taken this course!"
  }, presence: { message: "A course must be selected!" }
end
