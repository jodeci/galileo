# frozen_string_literal: true
FactoryBot.define do
  factory :image do
    id { 1 }
    file { Rack::Test::UploadedFile.new("spec/photos/test.jpg", "image/jpg") }
    after(:create) do |image, proxy|
      proxy.file.close
    end
  end
end
