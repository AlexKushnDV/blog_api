# frozen_string_literal: true

class ArticleSerializer
  include JSONAPI::Serializer

  attributes :title, :content, :category, :date
  belongs_to :user, key: :author
  has_many :comments
  meta do |article|
    {
      comments_count: article.comments.count
    }
  end
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
