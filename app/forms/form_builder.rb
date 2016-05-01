class FormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :tag, to: :@template
  delegate :errors, to: :@object

  %w(text_field email_field number_field password_field).each do |method_name|
    define_method(method_name) do |name, options = {}|
      error = text_field_error(name)
      options[:class] ||= ''
      options[:class] = options[:class] + ' mdl-textfield__input'

      content_tag :div, class: error do
        super(name, options) + text_field_label(name)
      end
    end
  end

  def radio_button(name, value, options = {})
    label_text = options.delete(:label)
    options[:class] ||= ''
    options[:class] = options[:class] + 'mdl-radio__button'

    content_tag :label, class: 'mdl-radio mdl-js-radio mdl-js-ripple-effect' do
      super(name, value, options) +
        content_tag(:span, class: 'mdl-radio__label') { label_text }
    end
  end

  def check_box(method, options = {}, checked_val = '1', unchecked_val = '0')
    label_text = options.delete(:label)
    options[:class] ||= ''
    options[:class] = options[:class] + 'mdl-checkbox__input'

    content_tag :label, class: mdl_checkbox_classes do
      super(method, options, checked_val, unchecked_val) +
        content_tag(:span, class: 'mdl-checkbox__label') { label_text }
    end
  end

  def collection_select(method, collection, value_method, text_method, options = {})
    error_msg = errors[method.to_s.gsub('_id', '').to_sym][0]

    content_tag :div, class: "input-field #{'is-invalid' unless error_msg.blank?}" do
      super(method, collection, value_method, text_method, options) +
        if !error_msg.blank?
          content_tag(:label, error_msg, class: 'active')
        else
          ''
        end
    end
  end

  def submit(value = nil, options = {})
    options[:class] ||= ''
    options[:class] = options[:class] + 'mdl-button'

    super(value, options)
  end

  private

  def text_field_label(name)
    label(name, options[:label], class: 'mdl-textfield__label') +
      content_tag(:span, class: 'mdl-textfield__error') do
        errors[name.to_sym][0]
      end
  end

  def text_field_error(name)
    'mdl-textfield mdl-js-textfield ' +
      (errors[name.to_sym].blank? ? '' : 'is-invalid')
  end

  def mdl_checkbox_classes
    'mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect'
  end
end