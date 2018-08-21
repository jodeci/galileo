# frozen_string_literal: true
module ImageDecorator
  def resized(size)
    image_tag ImageVariant.new(file).send(size)
  end
end
