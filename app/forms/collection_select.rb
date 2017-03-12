# frozen_string_literal: true
module CollectionSelect
  def collection_select(method, collection, val_method, text_method, opts = {})
    content_tag :div, collection_select_attrs(opts) do
      collection_select_prompt(opts[:prompt]) + hidden_field(method) +
      content_tag(:div, class: "mdc-simple-menu mdc-select__menu") do
        content_tag(:ul, class: "mdc-list mdc-simple-menu__items") do
          material_options(
            collection, val_method, text_method, object.send(method)
          )
        end
      end
    end
  end

  def material_options(collection, value_method, text_method, selected = nil)
    collection.collect do |record|
      options = {
        class: "mdc-list-item", role: :option,
        id: record.send(value_method), tabindex: 0
      }

      options["aria-selected"] = true if selected == record.send(value_method)

      content_tag(:li, record.send(text_method), options)
    end.join.html_safe
  end

  private

  def collection_select_prompt(prompt)
    content_tag(:span, prompt, class: "mdc-select__selected-text")
  end

  def collection_select_attrs(options)
    { class: "mdc-select #{options[:class]}", role: :listbox, tabindex: 0 }
  end
end
