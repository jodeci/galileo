# frozen_string_literal: true
include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :image do
    id { 1 }
    file { fixture_file_upload(Rails.root.join("spec", "photos", "test.jpg"), "image/jpg") }
  end
end
