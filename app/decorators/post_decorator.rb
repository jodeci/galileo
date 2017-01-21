# frozen_string_literal: true
module PostDecorator
  def published_date
    return unless published_at
    published_at.strftime("%Y-%m-%d")
  end

  def status_translated
    jr_value :status, status, :post
  end
end
