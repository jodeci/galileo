# frozen_string_literal: true
class BaseController < Shikigami::BaseController
  # assign for active_decorator
  before_action :assign_current_collection, only: [:index, :taglist]
  before_action :assign_current_object, only: [:show, :edit]

  private

  def assign_current_collection
    current_collection
  end

  def assign_current_object
    current_object
  end
end
