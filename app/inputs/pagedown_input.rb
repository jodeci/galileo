# frozen_string_literal: false
class PagedownInput < SimpleForm::Inputs::TextInput
  def input(wrapper_options)
    out = []
    out << content_tag(:div, nil, id: "wmd-button-bar-#{attribute_name}")
    out << wmd_input
    if input_html_options[:preview]
      out << content_tag(:div, nil, id: "wmd-preview-#{attribute_name}", class: "wmd-preview")
    end
    safe_join(out)
  end

  private

  def wmd_input
    @builder.text_area(
      attribute_name,
      input_html_options.merge(
        id: "wmd-input-#{attribute_name}",
        class: "wmd-input form-control"
      )
    )
  end
end
