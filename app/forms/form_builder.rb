class FormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :tag, to: :@template
  delegate :errors, to: :@object

  %w(text_field email_field number_field password_field).each do |method_name|
    define_method(method_name) do |name, options = {}|
      error = text_field_error(name)
      options[:class] ||= ""
      options[:class] = options[:class] + " mdl-textfield__input"

      content_tag :div, class: error do
        super(name, options) + text_field_label(name)
      end
    end
  end

  def radio_button(name, value, options = {})
    label_text = options.delete(:label)
    options[:class] ||= ""
    options[:class] = options[:class] + "mdl-radio__button"

    content_tag :label, class: "mdl-radio mdl-js-radio mdl-js-ripple-effect" do
      super(name, value, options) +
        content_tag(:span, class: "mdl-radio__label") { label_text }
    end
  end

  def check_box(method, options = {}, checked_val = "1", unchecked_val = "0")
    label_text = options.delete(:label) || method.to_s.capitalize
    label_for = "#{object.class.to_s.underscore}_#{method}"

    content_tag :div, class: "input-field materialize-checkbox" do
      super(method, options, checked_val, unchecked_val) +
        content_tag(:label, label_text, for: label_for)
    end
  end

  def collection_select(method, collection, value, text, opts = {}, html = {})
    error_msg = errors[method.to_s.gsub("_id", "").to_sym][0]
    div_class = "input-field #{'is-invalid' unless error_msg.blank?}"

    content_tag :div, class: div_class do
      super(method, collection, value, text, opts, html) +
        if !error_msg.blank?
          content_tag(:label, error_msg, class: "active")
        else
          ""
        end
    end
  end

  def select(method, choices = nil, options = {}, html_options = {})
    error_msg = errors[method.to_s.gsub("_id", "").to_sym][0]
    div_class = "input-field #{'is-invalid' unless error_msg.blank?}"

    content_tag :div, class: div_class do
      super(method, choices, options, html_options) +
        if !error_msg.blank?
          content_tag(:label, error_msg, class: "active")
        else
          ""
        end
    end
  end

  def submit(value = nil, options = {})
    options[:class] = "#{options[:class]} mdl-button #{submit_class}"

    super(value, options)
  end

  private

  def submit_class
    object.new_record? ? "create" : "update"
  end

  def text_field_label(name)
    label(name, options[:label], class: "mdl-textfield__label") +
      content_tag(:span, class: "mdl-textfield__error") do
        errors[name.to_sym][0]
      end
  end

  def text_field_error(name)
    "mdl-textfield mdl-js-textfield " +
      (errors[name.to_sym].blank? ? "" : "is-invalid")
  end
end
