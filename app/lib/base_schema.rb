# frozen_string_literal: true
class BaseSchema < Dry::Validation::Schema
  configure do |config|
    config.messages_file = "config/locales/errors.#{I18n.locale}.yml"
    config.messages = :i18n
  end
end
