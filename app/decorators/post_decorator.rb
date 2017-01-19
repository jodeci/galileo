# frozen_string_literal: true
module PostDecorator
  def headline
    access? ? public_headline : protected_headline
  end

  def public_headline
    content_tag :div, nil, class: "headline" do
      concat cover_image_block
      concat abstract_block
    end
  end

  def protected_headline
    content_tag :p, nil, class: "abstract" do
      concat "these are not the droids you are looking for"
      concat link_to foundation_icon("lock"), post_path(slug)
    end
  end

  def meta
    content_tag :div, nil, class: "meta" do
      concat date_with_icon
      tag_with_icon
    end
  end

  def published_date
    return unless published_at
    published_at.strftime("%Y-%m-%d")
  end

  def status_translated
    jr_value :status, status
  end

  def taglist_for_dashboard
    safe_join((tag_list.map { |tag| link_to tag, dashboard_posts_taglist_path(tag) }), ", ")
  end

  private

  def tag_with_icon
    tag_list.map do |tag|
      concat foundation_icon("price-tag")
      concat link_to tag, posts_taglist_path(tag)
    end
  end

  def cover_image_block
    return unless cover_image
    content_tag :div, nil, class: cover_image_class do
      link_to image_tag_by_id(cover_image, class: "thumbnail"), post_path(slug)
    end
  end

  def cover_image_class
    if abstract.blank?
      "cover_image"
    else
      "cover_image float-left"
    end
  end

  def abstract_block
    content_tag :p, nil, class: "abstract" do
      concat abstract_link
      concat link_to foundation_icon("page"), post_path(slug)
    end
  end

  def abstract_link
    if abstract.blank?
      link_to t("misc.read_more"), post_path(slug)
    else
      abstract
    end
  end

  def date_with_icon
    content_tag :span, nil, class: "date" do
      concat foundation_icon("calendar")
      concat published_date
    end
  end

  def access?
    if status == "public"
      true
    else
      false # TODO: based on session password
    end
  end
end
