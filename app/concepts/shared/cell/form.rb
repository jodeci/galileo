# frozen_string_literal: true
module Shared::Cell
  module Form
    include Formular::RailsHelper

    def form_for(**options, &block)
      options[:method] = method
      options[:builder] = :bootstrap3
      trb_form_for(model, url, options, &block)
    end

    def url
      url_for(action: action, controller: params[:controller], only_path: true)
    end

    def action
      model.model.new_record? ? :create : :update
    end

    def method
      model.model.new_record? ? :post : :put
    end
  end
end
