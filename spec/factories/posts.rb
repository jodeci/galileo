# frozen_string_literal: true
FactoryGirl.define do
  factory :post do
    title { Faker::Book.title }
    slug { Faker::Internet.slug }
  end
end
