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
end
