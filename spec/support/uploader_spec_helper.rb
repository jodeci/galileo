# frozen_string_literal: true
module UploaderSpecHelper
  def create_file_blob(filename: "image.jpg", content_type: "image/jpeg", metadata: { exif: {} })
    ActiveStorage::Blob.create_after_upload!(
      io: file_fixture(filename).open,
      filename: filename,
      content_type: content_type,
      metadata: metadata
    )
  end
end
