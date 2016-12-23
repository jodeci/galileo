# frozen_string_literal: false
class PagedownInput < SimpleForm::Inputs::TextInput
  def input(wrapper_options = {})
    out = "<div id=\"wmd-button-bar-#{attribute_name}\"></div>#{wmd_input}"
    if input_html_options[:preview]
      out << "<div id=\"wmd-preview-#{attribute_name}\" class=\"wmd-preview\"></div>"
    end
    out.html_safe
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
