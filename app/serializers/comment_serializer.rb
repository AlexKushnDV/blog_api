# frozen_string_literal: true

class CommentSerializer
  include JSONAPI::Serializer
  attributes :content
  belongs_to :article
end
