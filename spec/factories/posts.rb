# frozen_string_literal: true
FactoryGirl.define do
  factory :post do
    title { Faker::Book.title }
    slug { Faker::Internet.slug }
    cover_image { 1 }
  end
end
