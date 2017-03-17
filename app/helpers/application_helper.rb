# frozen_string_literal: true
module ApplicationHelper
  def fab(link, fixed = true)
    button_classes =
      "mdc-fab material-icons new-fab #{'app-fab--absolute' if fixed}"

    link_to link, class: button_classes, "data-mdc-auto-init" => "MDCRipple" do
      content_tag(:span, class: "mdc-fab__icon") do
        "add"
      end
    end
  end

  def active_semester
    @active_semester ||= Semester.active
  end

  def current_semester
    @current_semester ||=
      Semester.find_by(id: session[:semester_id]) || active_semester
  end
end
