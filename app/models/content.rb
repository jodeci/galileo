# frozen_string_literal: true
class Content < ApplicationRecord
  STATUS = [:draft, :private, :protected, :public]
end
