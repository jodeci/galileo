# frozen_string_literal: true
FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    slug { Faker::Lorem.words(4, true).join("-") }
    cover_image { 1 }

    trait :published do
      status { :published }
      published_at { Time.zone.parse("2014-03-18") }
    end

    trait :password_protected do
      status { :password_protected }
      published_at { Time.zone.parse("2014-03-23") }
    end

    trait :draft do
      cover_image { nil }
      status { :draft }
    end

    trait :abstract do
      abstract { "abstract text" }
    end
  end
end
