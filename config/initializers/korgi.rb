Korgi.configure do |config|
  config.named_routes = { post: { controller: "frontend/posts" } }
  # config.file_uploads = { image: { model: Image, mount: :file, default_version: :medium, nil_object: NullImage } }
end
