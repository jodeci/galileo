# frozen_string_literal: true
module PostDecorator
  def published_date
    return unless published_at
    published_at.strftime("%Y-%m-%d")
  end

  def status_translated
    jr_value :status, status, :post
  end

  def abstract_text
    abstract || I18n.t("misc.default_abstract")
  end

  def description
    abstract || I18n.t("misc.default_description")
  end

  def open_graph
    {
      title: title,
      site_name: I18n.t("misc.site_name"),
      type: "website",
      url: post_url(slug),
      description: description,
      image: cover_image_url,
    }.compact
  end

  def cover
    return unless cover_image?
    content_tag :div, class: "cover_image" do
      resized_cover(:large)
    end
  end

  def linked_cover
    return unless cover_image?
    content_tag :div, class: headline_cover_style do
      link_to resized_cover(:medium), post_path(self)
    end
  end

  def resized_cover(size)
    image_tag ImageVariant.by_id(cover_image).send(size), class: "thumbnail"
  end

  private

  def cover_image_url
    request.protocol + request.host_with_port + cover_image_path
  end

  def headline_cover_style
    abstract? ? "cover_image float-left" : "cover_image"
  end

  def cover_image_path
    if cover_image?
      url_for Image.fetch(cover_image).file
    else
      asset_path Settings.profile.image
    end
  end
end
