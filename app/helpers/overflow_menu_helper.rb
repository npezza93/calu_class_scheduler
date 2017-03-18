# frozen_string_literal: true
module OverflowMenuHelper
  def overflow_menu(edit_link: nil, destroy_link: nil, other: nil)
    content_tag(:div, class: "relative overflow-menu") do
      material_icon.more_vert.css_class("menu-toggle").to_s +
        content_tag(:div, class: "mdc-simple-menu", tabindex: -1) do
          overflow_menu_items(edit_link, destroy_link, other)
        end
    end
  end

  private

  def overflow_edit_link(link)
    link_to link, class: "mdc-list-item", role: :menuitem, tabindex: 0 do
      material_icon.mode_edit.css_class("mr-2").to_s + "Edit"
    end
  end

  def overflow_destroy_link(link)
    link_to link, class: "mdc-list-item", method: :delete, tabindex: 0,
                  data: { confirm: "Are you sure?" }, role: :menuitem do
      material_icon.delete.css_class("mr-2").to_s + "Delete"
    end
  end

  def overflow_menu_items(edit_link, destroy_link, other)
    content_tag(:div, class: "mdc-simple-menu__items mdc-list",
                      role: :menu, aria: { hidden: true }) do
      if edit_link
        overflow_edit_link(edit_course_path(@course))
      end.to_s +
          if destroy_link
            overflow_destroy_link(course_path(@course))
          end.to_s + other.to_s
    end
  end
end
