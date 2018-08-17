# frozen_string_literal: true
class ImageVariant
  attr_accessor :file

  def initialize(id: nil, image: nil)
    if image
      @file = image.file
    else
      @file = Image.fetch(id).file
    end
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
    file.variant(resize: "500x500")
  end

  def large
    file.variant(resize: "800x800")
  end
end
