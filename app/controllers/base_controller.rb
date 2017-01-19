# frozen_string_literal: true
class BaseController < Shikigami::BaseController
  before_action :assign_collection, only: [:index, :taglist]

  private

  def assign_collection
    current_collection
  end
end
