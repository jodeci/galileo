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

  def bsb(action, path, options = {})
    bsb_options = {}
    bsb_options[:class] = bsb_class(action, options)
    bsb_options[:method] = options[:method] if options[:method]
    bsb_options[:data] = { confirm: t("confirm.#{action}") } if options[:confirm]
    link_to t("actions.#{action}"), path, bsb_options
  end

  def no_data_alert(message = t("warnings.no_data"))
    content_tag :div, message, class: "alert alert-warning"
  end

  private

  def bsb_class(action, options = {})
    size = options[:size] ? options[:size] : "xs"
    style = options[:style] ? options[:style] : bsb_style(action)
    "btn btn-#{size} btn-#{style}"
  end

  def bsb_style(action)
    case action
    when :show then "info"
    when :edit then "warning"
    when :destroy then "danger"
    else "primary"
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
