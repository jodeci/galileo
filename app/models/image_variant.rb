# frozen_string_literal: true
class ImageVariant
  attr_accessor :file

  def initialize(file)
    @file = file
  end

  def self.by_id(id)
    self.new Image.fetch(id).file
  end

  def thumb
    file.variant(
      combine_options: {
        auto_orient: true,
        gravity: "center",
        resize: "100x100^",
        crop: "100x100+0+0",
      }
    )
  end

  def medium
    file.variant(
      combine_options: {
        auto_orient: true,
        resize: "500x500",
      }
    )
  end

  def large
    file.variant(
      combine_options: {
        auto_orient: true,
        resize: "800x800",
      }
    )
  end
end
