# frozen_string_literal: true
require_dependency "app/concepts/post/cells/base"

module Post::Cell
  module Frontend
    class Base < Post::Cell::Base
      def tag_list
        safe_join((model.tag_list.map { |tag| link_to tag, posts_taglist_path(tag) }), ", ")
      end
    end

    class Index < Base
    end

    class Taglist < Base
    end

    class Show < Base
    end
  end
end
