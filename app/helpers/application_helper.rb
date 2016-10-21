# frozen_string_literal: true
module ApplicationHelper
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
end
