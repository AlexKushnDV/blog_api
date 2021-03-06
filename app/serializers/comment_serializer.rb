# frozen_string_literal: true

class CommentSerializer
  include JSONAPI::Serializer

  attributes :content

  belongs_to :article
  belongs_to :user

  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
