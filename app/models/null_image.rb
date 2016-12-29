# frozen_string_literal: true
class NullImage
  attr_reader :path

  def self.path
    ActionController::Base.helpers.asset_path("no_image.svg")
  end
end
