# frozen_string_literal: false
class PagedownInput < SimpleForm::Inputs::TextInput
  def input(_wrapper_options)
    output = []
    output << content_tag(:div, nil, id: "wmd-button-bar-#{attribute_name}")
    output << wmd_input
    output << wmd_preview if input_html_options[:preview]
    safe_join(output)
  end

  private

  def wmd_preview
    content_tag(:div, nil, id: "wmd-preview-#{attribute_name}", class: "wmd-preview")
  end

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
