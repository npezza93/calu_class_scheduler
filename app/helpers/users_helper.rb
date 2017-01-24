module UsersHelper
  def schedule_status(user)
    if user.courses.size.zero?
      { class: "student-no-courses-link", display: "No Schedule" }
    elsif user.schedule_approval && user.schedule_approval.approved
      { class: "student-pending-link", display: "Approved" }
    elsif user.schedule_approval && !user.schedule_approval.approved
      { class: "student-pending-link", display: "Pending" }
    else
      { class: "student-schedule-link", display: "Schedule" }
    end
  end
end
