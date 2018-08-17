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

  def cover_image_url
    request.protocol + request.host_with_port + cover_image_path
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

  private

  def cover_image_path
    if cover_image?
      url_for Image.fetch(cover_image).file
    else
      asset_path Settings.profile.image
    end
  end
end
