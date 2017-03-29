# frozen_string_literal: true

# == Schema Information
#
# Table name: schedule_approvals
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  approved    :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#  semester_id :integer
#

class ScheduleApproval < ApplicationRecord
  belongs_to :user
  belongs_to :semester

  validates :user_id, uniqueness: { scope: %i(semester_id) }

  after_create :send_to_advisor
  after_create :send_student_confirmation
  after_update :send_advisor_confirmation
  after_update :send_approved

  def approve
    update(approved: true)
  end

  def send_to_advisor
    UserMailer.submit_to_advisor(self).deliver_later
  end

  def send_student_confirmation
    UserMailer.student_confirmation(self).deliver_later
  end

  def send_advisor_confirmation
    UserMailer.advisor_confirmation(self).deliver_later
  end

  def send_approved
    UserMailer.approved(self).deliver_later
  end
end
