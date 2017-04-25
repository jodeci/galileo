# frozen_string_literal: true
module Post::Cell::Frontend
  class Base < Post::Cell::Base
    def tag_list
      safe_join((model.tag_list.map { |tag| link_to tag, posts_taglist_path(tag) }), ", ")
    end
  end

  class Index < Base
  end

  class Show < Base
  end
end
