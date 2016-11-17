# frozen_string_literal: true
FactoryGirl.define do
  factory :content do
    title { Faker::Book.title }
    slug { Faker::Internet.slug }
  end
end
