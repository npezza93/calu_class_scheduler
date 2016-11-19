module ApplicationHelper
  def new_fab(link, fixed = true)
    button_classes = "#{fab_classes} new-fab #{'fixed' if fixed}"
    link_to link do
      content_tag(:button, class: button_classes) do
        content_tag(:i, "add", class: "material-icons")
      end
    end
  end

  def edit_fab(link)
    button_classes = "#{fab_classes} edit-fab fixed"
    link_to link do
      content_tag(:button, class: button_classes) do
        content_tag(:i, "edit", class: "material-icons")
      end
    end
  end

  def destroy_fab(link, confirm_message = nil)
    confirm_message ||= "Are you sure?"
    link_to link, data: { method: :delete, confirm: confirm_message } do
      content_tag(:button, class: "#{fab_classes} destroy-fab fixed") do
        content_tag(:i, "clear", class: "material-icons")
      end
    end
  end

  def fab_classes
    "mdl-button mdl-js-button mdl-button--fab"
  end
end
