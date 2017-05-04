# frozen_string_literal: true
module Shared::Cell
  module Paginate
    class Base < Trailblazer::Cell
      include Kaminari::Cells
      extend ViewName::Flat
    end

    class Dashboard < Base
      def theme
        "bootstrap"
      end
    end

    class Frontend < Base
      def theme
        "foundation"
      end
    end
  end
end
