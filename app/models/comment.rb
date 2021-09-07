# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :content, :user_id, :article_id, presence: true
  validates :content, length: { maximum: 1000 }
end
