class FormBuilder < ActionView::Helpers::FormBuilder
  def text_field(name, options = {})
    error = 'mdl-textfield mdl-js-textfield ' +
            (@object.errors[name.to_sym].blank? ? '' : 'is-invalid')
    options[:class] ||= ''
    options[:class] = options[:class] + 'mdl-textfield__input'

    @template.content_tag :div, class: error, style: options[:style] do
      super(name, options) +
        label(name, options[:label], class: 'mdl-textfield__label') +
        @template.content_tag(:span, class: 'mdl-textfield__error') do
          @object.errors[name.to_sym][0]
        end
    end
  end

  def email_field(name, options = {})
    error = 'mdl-textfield mdl-js-textfield ' +
            (@object.errors[name.to_sym].blank? ? '' : 'is-invalid')
    options[:class] ||= ''
    options[:class] = options[:class] + 'mdl-textfield__input'

    @template.content_tag :div, class: error, style: options[:style] do
      super(name, options) +
        label(name, options[:label], class: 'mdl-textfield__label') +
        @template.content_tag(:span, class: 'mdl-textfield__error') do
          @object.errors[name.to_sym][0]
        end
    end
  end

  def number_field(name, options = {})
    error = 'mdl-textfield mdl-js-textfield ' +
            (@object.errors[name.to_sym].blank? ? '' : 'is-invalid')
    options[:class] ||= ''
    options[:class] = options[:class] + 'mdl-textfield__input'
    options[:pattern] = '-?[0-9]*(\.[0-9]+)?'

    @template.content_tag :div, class: error, style: options[:style] do
      super(name, options) +
        label(name, options[:label], class: 'mdl-textfield__label') +
        @template.content_tag(:span, class: 'mdl-textfield__error') do
          @object.errors[name.to_sym][0]
        end
    end
  end

  def password_field(name, options = {})
    error = 'mdl-textfield mdl-js-textfield ' +
            (@object.errors[name.to_sym].blank? ? '' : 'is-invalid')
    options[:class] ||= ''
    options[:class] = options[:class] + ' mdl-textfield__input'

    @template.content_tag :div, class: error do
      super(name, options) +
        label(name, options[:label], class: 'mdl-textfield__label') +
        @template.content_tag(:span, class: 'mdl-textfield__error') do
          @object.errors[name.to_sym][0]
        end
    end
  end

  def radio_button(name, value, options = {})
    label_text = options.delete(:label)
    options[:class] ||= ''
    options[:class] = options[:class] + 'mdl-radio__button'

    @template.content_tag :label, class: 'mdl-radio mdl-js-radio mdl-js-ripple-effect' do
      super(name, value, options) +
        @template.content_tag(:span, class: 'mdl-radio__label') do
          label_text
        end
    end
  end

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    label_text = options.delete(:label)
    options[:class] ||= ''
    options[:class] = options[:class] + 'mdl-checkbox__input'

    @template.content_tag :label, class: 'mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect' do
      super(method, options, checked_value, unchecked_value) +
        @template.content_tag(:span, class: 'mdl-checkbox__label') do
          label_text
        end
    end
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    random = SecureRandom.base64
    if object.send(method)
      value = object.send(method)
      text = collection.find(value).send(text_method)
    else
      value = collection.first.send(value_method)
      text = collection.first.send(text_method)
    end

    @template.content_tag :div, class: div_classes_for_select(object.errors[method.to_s.gsub('_id', '').to_sym].blank?) do
      hidden_field(method, value: value) +
        @template.content_tag(:input, nil, select_input_attrs(random, value, text)) +

        @template.content_tag(:label, for: random) do
          @template.content_tag(:i, 'keyboard_arrow_down', select_arrow)
        end +

        @template.content_tag(:span, class: 'mdl-textfield__error') do
          object.errors[method.to_s.gsub('_id', '').to_sym][0]
        end +

        @template.content_tag(:label, for: random) do
          @template.content_tag(:i, options[:prompt], class: 'mdl-textfield__label')
        end +

        @template.content_tag(:ul, select_ul_class(random)) do
        collection.collect { |item| @template.concat(@template.content_tag(:li, item.send(text_method), class: 'mdl-menu__item', value: item.send(value_method)))}
      end
    end
  end

  def submit(value = nil, options = {})
    options[:class] ||= ''
    options[:class] = options[:class] + 'mdl-button'

    super(value, options)
  end

  private

  def div_classes_for_select(error)
    s = %(mdl-textfield mdl-js-textfield mdl-textfield--floating-label)
    s += ' getmdl-select'

    if !error
      s + ' is-invalid'
    else
      s
    end
  end

  def select_input_attrs(random, value, text)
    {
      class: 'mdl-textfield__input',
      id: random,
      readonly: 'readonly',
      tabindex: '-1',
      type: 'text',
      select_value: value,
      value: text
    }
  end

  def select_arrow
    {
      class: 'mdl-icon-toggle__label material-icons'
    }
  end

  def select_ul_class(random)
    {
      for: random,
      class: 'mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect'
    }
  end
end
