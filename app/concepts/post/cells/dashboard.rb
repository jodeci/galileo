# frozen_string_literal: true
require_dependency "app/concepts/post/cells/base"
require_dependency "app/concepts/shared/cell"

module Post::Cell
  module Dashboard
    class Base < Post::Cell::Base
      include Formular::RailsHelper
      include ActionView::Helpers::DebugHelper

      def tag_list
        safe_join((model.tag_list.map { |tag| link_to tag, dashboard_posts_taglist_path(tag) }), ", ")
      end
    end

    class Index < Base
    end

    class Taglist < Base
    end

    class List < Base
    end

    class Item < Base
    end

    class Show < Base
    end

    class New < Base
    end

    class Edit < Base
    end

    class Form < Base
      include Shared::Cell::Form
    end
  end
end
