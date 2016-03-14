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
    random = SecureRandom.base64
    if object.send(method)
      value = object.send(method)
      text = collection.find(value).send(text_method)
    else
      value = collection.first.send(value_method)
      text = collection.first.send(text_method)
    end

    content_tag :div, class: div_classes_for_select(method) do
      hidden_field(method, value: value) +
        generate_content_for_select(method, random, value, text) +

        content_tag(:label, for: random) do
          content_tag(:i, options[:prompt], class: 'mdl-textfield__label')
        end +

        content_tag(:ul, select_ul_class(random)) do
          collection.collect { |item| @template.concat(content_tag(:li, item.send(text_method), class: 'mdl-menu__item', value: item.send(value_method)))}
        end
    end
  end

  def submit(value = nil, options = {})
    options[:class] ||= ''
    options[:class] = options[:class] + 'mdl-button'

    super(value, options)
  end

  private

  def generate_content_for_select(method, random, value, text)
    content_tag(:input, nil, select_input_attrs(random, value, text)) +
      content_tag(:label, for: random) do
        content_tag(:i, 'keyboard_arrow_down', select_arrow)
      end +

      content_tag(:span, class: 'mdl-textfield__error') do
        errors[method.to_s.gsub('_id', '').to_sym][0]
      end
  end

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

  def div_classes_for_select(method)
    error = errors[method.to_s.gsub('_id', '').to_sym].blank?
    s = %(mdl-textfield mdl-js-textfield mdl-textfield--floating-label)
    s += ' getmdl-select'

    !error ? s + ' is-invalid' : s
  end

  def select_input_attrs(random, value, text)
    { class: 'mdl-textfield__input',
      id: random,
      readonly: 'readonly',
      tabindex: '-1',
      type: 'text',
      select_value: value,
      value: text }
  end

  def select_arrow
    { class: 'mdl-icon-toggle__label material-icons' }
  end

  def select_ul_class(random)
    { for: random,
      class: 'mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect' }
  end
end
