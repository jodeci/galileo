# frozen_string_literal: true
FactoryGirl.define do
  factory :post do
    title { Faker::Book.title }
    slug { Faker::Lorem.words(4, true).join("-") }
    cover_image { 1 }

    trait :public do
      status { "public" }
      published_at { Time.zone.parse("2014-03-18") }
    end

    trait :protected do
      status { "protected" }
      published_at { Time.zone.parse("2014-03-23") }
    end

    trait :draft do
      cover_image { nil }
      status { "draft" }
    end

    trait :abstract do
      abstract { "abstract text" }
    end
  end
end
