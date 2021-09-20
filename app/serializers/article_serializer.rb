# frozen_string_literal: true

class ArticleSerializer
  include JSONAPI::Serializer

  belongs_to :user, key: :author
  has_many :comments

  attributes :title, :content, :category

  attribute :date do |object|
    object.created_at.to_date.to_s
  end

  meta do |article|
    {
      comments_count: article.comments.count
    }
  end

  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
