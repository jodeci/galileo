Korgi.configure do |config|
  config.named_routes = { post: "frontend/posts" }
  config.file_uploads = { image: [Image, :file, :medium] }
end
