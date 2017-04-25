# frozen_string_literal: true
module Post::Cell::Dashboard
  class Base < Post::Cell::Base
    include Formular::RailsHelper
    include ActionView::Helpers::DebugHelper

    def tag_list
      safe_join((model.tag_list.map { |tag| link_to tag, dashboard_posts_taglist_path(tag) }), ", ")
    end
  end

  class Index < Base
  end

  class Show < Base
  end

  class New < Base
  end

  class Edit < Base
  end

  # TODO: make a base form cell
  class Form < Base
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
