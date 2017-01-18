# frozen_string_literal: true
module PostDecorator
  def headline
    content_tag :div, nil, class: "headline" do
      concat cover_link
      concat abstract_block
    end
  end

  def taglist_with_icons
    return unless tag_list.any?
    content_tag :div, nil, class: "tags" do
      tag_with_icon
    end
  end

  private

  def tag_with_icon
    tag_list.map do |tag|
      concat foundation_icon("price-tag")
      concat link_to tag, posts_taglist_path(tag)
    end
  end

  def cover_link
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
end
