# frozen_string_literal: true
module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      autolink: true,
      tables: true,
      underline: true,
      highlight: true
    )
    markdown.render(text).html_safe
  end

  def dropdown_title(title)
    content_tag :a, dropdown_title_hash do
      concat title
      concat content_tag :span, nil, class: "caret"
    end
  end

  def dropdown_title_hash
    {
      "class": "dropdown-toggle",
      "data-toggle": "dropdown",
      "role": "button",
      "aria-haspopup": "true",
      "aria-expanded": "false"
    }
  end

  # ::Object::CONSTANT defined in object model
  # translation defined in meta_data.yml
  def option_hash(attribute)
    options = {}
    scope = "options.#{current_object.model_name.param_key}.#{attribute}"
    Object.const_get("::#{current_object.model_name}::#{attribute.upcase}").map do |i|
      options[t(i, scope: scope)] = i
    end
    options
  end
end
