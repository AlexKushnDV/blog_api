# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :content, :user_id, presence: true
  validates :title, length: { maximum: 100 }
end
