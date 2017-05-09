# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    username { "Yukawa" }
    email { "yukawa@physics.teito.ac.jp" }
    password { "12345678" }
  end
end
