# frozen_string_literal: true

class ArticleDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def content
    model.content.truncate(503)
  end
end
