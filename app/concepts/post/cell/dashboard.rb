# frozen_string_literal: true
require_dependency "./app/concepts/post/cell/base"
require_dependency "./app/concepts/shared/cell/form"
require_dependency "./app/concepts/shared/cell/paginate"

module Post::Cell
  module Dashboard
    class Base < Post::Cell::Base
      def tag_list
        safe_join((model.tag_list.map { |tag| link_to tag, dashboard_posts_taglist_path(tag) }), ", ")
      end
    end

    class Form < Base
      include Shared::Cell::Form
    end

    class Paginate < Shared::Cell::Paginate::Dashboard
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
  end
end
