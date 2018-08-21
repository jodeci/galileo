# frozen_string_literal: true
class NullImage
  attr_reader :file

  class << self
    def file
      NullImageFile
    end

    def asset_path(size)
      ActionController::Base.helpers.asset_path("no_image_#{size}.png")
    end
  end
end

class NullImageFile
  class << self
    def variant(options)
      case options.dig(:combine_options).dig(:resize)
      when "100x100^" then thumb
      when "500x500" then medium
      when "800x800" then large
      end
    end

    def thumb
      NullImage.asset_path("thumb")
    end

    def medium
      NullImage.asset_path("medium")
    end

    def large
      NullImage.asset_path("large")
    end
  end
end
