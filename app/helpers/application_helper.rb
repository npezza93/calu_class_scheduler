# frozen_string_literal: true

module ApplicationHelper
  def fab(link)
    button_classes = "mdc-fab material-icons new-fab app-fab--absolute"

    link_to link, class: button_classes, "data-mdc-auto-init" => "MDCRipple" do
      content_tag(:span, "add", class: "mdc-fab__icon")
    end
  end

  def render_title(title)
    if title.present?
      "#{title} | CalU Advisor"
    else
      "CalU Advisor"
    end
  end

  def render_back_url(url)
    if url.present?
      link_to url, class: "white-text layout horizontal mr-3 ml-1" do
        material_icon.arrow_back.to_s
      end
    else
      content_tag(:i, nil, class: "mr-3 ml-1 material-icons")
    end
  end

  def mdc_check_box_tag(disabled = false, checked = false)
    content_tag(:div, class: "mdc-checkbox") do
      check_box_tag(
        nil, "1", checked,
        class: "mdc-checkbox__native-control", disabled: disabled
      ) + content_tag(:div, class: "mdc-checkbox__background") do
        check_box_svg + content_tag(:div, nil, class: "mdc-checkbox__mixedmark")
      end
    end
  end

  def drawer_link(link, icon, title, active_tab)
    opts =
      if title.downcase == active_tab.to_s
        { class: "active" }
      else
        {}
      end

    link_to link, opts do
      material_icon.send(icon).to_s + content_tag(:span, title)
    end
  end

  private

  def check_box_svg
    content_tag(:svg, class: "mdc-checkbox__checkmark", viewBox: "0 0 24 24") do
      content_tag(
        :path, nil,
        class: "mdc-checkbox__checkmark__path", fill: :none, stroke: :white,
        d: "M1.73,12.91, 8.1,19.28 22.79, 4.59"
      )
    end
  end
end
