# frozen_string_literal: true

module UsersHelper
  def schedule_status_display(user, schedule_approval)
    if user.schedules.for_semester(current_semester).blank?
      "No Schedule"
    elsif schedule_approval && schedule_approval.approved
      "Approved"
    elsif schedule_approval && !schedule_approval.approved
      "Pending"
    else
      "Schedule"
    end
  end

  def approve_schedule?
    current_user.schedule_approvals.for_semester(current_semester_id).empty? &&
      current_user.student?
  end
end
