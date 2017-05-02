# frozen_string_literal: true
module Shared::Cell
  module Helpers
    include I18n::Base
    include ActionView::Helpers::DebugHelper if Rails.env.development?
    include Shikigami::ViewHelpers

    def markdownify(content)
      HtmlPipeline::MarkdownRenderer.new(content).call
    end

    def image_tag_by_id(*args, **options)
      image_tag Image.fetch_url(*args), options
    end

    def jt(attribute)
      I18n.t("activerecord.attributes.#{model.model_name.param_key}.#{attribute}")
    end
  end

  module Form
    include Formular::RailsHelper

    def form_for(**options, &block)
      options[:method] = method
      options[:builder] = :bootstrap3
      trb_form_for(model, url, options, &block)
    end

    def url
      url_for(action: action, controller: params[:controller], only_path: true)
    end

    def action
      model.model.new_record? ? :create : :update
    end

    def method
      model.model.new_record? ? :post : :put
    end
  end
end
