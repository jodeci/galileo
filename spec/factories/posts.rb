# frozen_string_literal: true
FactoryGirl.define do
  factory :post do
    title { Faker::Book.title }
    slug { Faker::Internet.slug("foo bar", "-") }
    cover_image { 1 }

    trait :public do
      status { "public" }
      published_at { Time.zone.parse("2014-03-18") }
    end

    trait :protected do
      status { "protected" }
      published_at { Time.zone.parse("2014-03-18") }
    end
  end
end
