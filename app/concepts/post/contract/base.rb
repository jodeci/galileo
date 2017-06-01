# frozen_string_literal: true
require "reform/form/coercion"
require "reform/form/dry"

module Post::Contract
  class Base < Reform::Form
    feature Reform::Form::Coercion
    feature Reform::Form::Dry

    property :title
    property :slug
    property :body
    property :abstract
    property :cover_image
    property :status
    property :published_at
    property :featured, type: Types::Form::Bool
    property :tag_list

    validation schema: ::BaseSchema, with: { form: true } do
      configure do
        option :form

        def unique?(value)
          Post.where.not(id: form.model.id).where(slug: value).empty?
        end
      end

      required(:title).filled
      required(:slug).filled(format?: %r{\A[a-z0-9_-]+\z}, unique?: :slug)
      required(:cover_image) { filled? > int? & gt?(0) }

      required(:status).filled.when(included_in?: %w(published password_protected)) do
        value(:published_at).filled?
      end

      required(:featured).filled.when(:true?) do
        value(:status).eql?("published")
      end
    end
  end

  class Create < Base
  end

  class Update < Base
  end
end
